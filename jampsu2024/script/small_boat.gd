extends CharacterBody2D
class_name SmallBoat

const CANNONBALL_RES := preload("res://scenes/environment/cannonball_sea.tscn")
const GAMEOVER_SCREEN := preload("res://scenes/UI/GameOver.tscn")
const COAL_CONSUMPTION_TIME := 17.5
const COAL_CONS_MULT := {
	SPEEDS.REVERSE : 0.4,
	SPEEDS.STOPPED : 0.0,
	SPEEDS.SLOW : 0.4,
	SPEEDS.FAST : 0.8,
}

enum Directions {
	Top, TopLeft, Left, BottomLeft,
	Bottom, BottomRight, Right, TopRight
}
const DIRECTION_ANIMS = {
	Directions.Top : ["top_", false],
	Directions.TopLeft : ["top_right_", true],
	Directions.Left : ["right_", true],
	Directions.BottomLeft : ['down_right_', true],
	Directions.Bottom : ["down_", false],
	Directions.BottomRight : ["down_right_", false],
	Directions.Right : ["right_", false],
	Directions.TopRight : ["top_right_", false]
}

const MAX_OIL_TIME := 20.0

var oil_lightouse_remaining_time := MAX_OIL_TIME

enum SPEEDS {
	REVERSE = -70,
	STOPPED = 0,
	SLOW = 70,
	FAST = 140
} 

@onready var lines: Array[Line2D] = [
	$Icon/CanonLine1,
	$Icon/CanonLine2,
	$Icon/CanonLine3,
	$Icon/CanonLine4
]

var cannons_offsets = [
	Vector2(10, 10),
	Vector2(55, 10),
	Vector2(55, 40),
	Vector2(10, 40)
]
var can_move = true
var max_health = 100.0
var speed: float = 70
@export var current_speed:SPEEDS = SPEEDS.SLOW
@export var hit_obstacle_min_speed = 50
@export var health: float = max_health
@export var direction: Vector2 = Vector2(1,0)
@export var line_length = 500
@export var hit_cooldown_time = 2.0
var can_change_speed := true
var remaining_coal_time := COAL_CONSUMPTION_TIME

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalVariables.small_boat = self
	$health_debug.text = str(health) + "/" + str(max_health)
	$speed_debug.text = "speed : " + str(speed)

func hit_obstacle():
	if velocity.length() > hit_obstacle_min_speed:
		damage(10)
		can_move = false
		velocity = Vector2.ZERO  # TODO: rendre l'arrêt moins brutal ?
		await get_tree().create_timer(hit_cooldown_time).timeout
		can_move = true
		$health_debug.text = str(health) + "/" + str(max_health)
		
func ennemy_hit():
	damage(10)
	$health_debug.text = str(health) + "/" + str(max_health)

func move_light_house(rot_offset : float):
	$PointLightHouse.rotation += rot_offset

const DIR := {
	Left = Vector2.LEFT,
	Right = Vector2.RIGHT,
	Up = Vector2.UP,
	Down = Vector2.DOWN,
	
	UpLeft = Vector2.UP + Vector2.LEFT,
	UpRight = Vector2.UP + Vector2.RIGHT,
	DownLeft = Vector2.DOWN + Vector2.LEFT,
	DownRight = Vector2.DOWN + Vector2.RIGHT,		
}

func get_closest_dir(dir: Vector2) -> Vector2:
	var closest_distance: float = 9999.99
	var closest_dir := Vector2.ZERO
	
	var other_directions := DIR.values()
	for other_dir in other_directions:
		var distance = dir.distance_to(other_dir)
		if distance < closest_distance:
			closest_distance = distance
			closest_dir = other_dir
	return closest_dir

func play_dir_anim(dir: Vector2) -> void:
	var closest_dir := get_closest_dir(dir)
	var anim_name := ""
	match closest_dir:
		DIR.Left: 		set_ship_sprite(Directions.Left)
		DIR.Right: 		set_ship_sprite(Directions.Right)
		DIR.Up: 			set_ship_sprite(Directions.Top)
		DIR.Down: 		set_ship_sprite(Directions.Bottom)
		DIR.UpLeft: 		set_ship_sprite(Directions.TopLeft)
		DIR.UpRight: 	set_ship_sprite(Directions.TopRight)
		DIR.DownLeft: 	set_ship_sprite(Directions.BottomLeft)
		DIR.DownRight:	set_ship_sprite(Directions.BottomRight)

func set_turn(value : float):
	direction = direction.rotated(value)
	$Icon.rotation += value
	play_dir_anim(Vector2.RIGHT.rotated($Icon.rotation))

func set_ship_sprite(d : Directions):
	$AnimatedSprite2D.play(DIRECTION_ANIMS[d][0] + "m")
	$AnimatedSprite2D.flip_h = DIRECTION_ANIMS[d][1]

func damage(damage: float):
	health -= damage
	$Camera2D/CameraUtils.shake(0.3, 7, 20, 2)
	if health == 0:
		show_game_over()
		
func show_game_over():
	get_tree().change_scene_to_packed(GAMEOVER_SCREEN)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	oil_lightouse_remaining_time -= delta
	if oil_lightouse_remaining_time <= 0.0:
		if GlobalVariables.light_house.consume_OIL():
			$PointLightHouse.visible = true
			oil_lightouse_remaining_time = MAX_OIL_TIME
		else:
			$PointLightHouse.visible = false
	$coal_debug.text = str(remaining_coal_time)
	#remaining_coal_time -= delta * COAL_CONS_MULT[current_speed]
	#if remaining_coal_time <= 0.0 and current_speed != SPEEDS.STOPPED:
		#if GlobalVariables.steam_engine.consume_coal():
			#remaining_coal_time = COAL_CONSUMPTION_TIME
		#else:
			#set_speed(SPEEDS.STOPPED)

func _physics_process(_delta: float) -> void:
	$speed_debug.text = "speed : " + str(speed)
	if can_move:
		velocity = direction.normalized() * speed
		move_and_slide()

func set_speed(value: SPEEDS):
	current_speed = value
	var t := create_tween().set_trans(Tween.TRANS_CUBIC)
	t.tween_property(self, "speed", value, 0.9)

func set_line_direction(index: int, direction: float):
	lines[index].rotation = direction

func set_line_visibility(index : int, new_visibility : bool):
	lines[index].visible = new_visibility

func set_speed_change(speed_offset : float):
	if can_change_speed:
		can_change_speed = false
		if speed_offset < -0.5:
			if current_speed == SPEEDS.FAST:
				set_speed(SPEEDS.SLOW)
			elif current_speed == SPEEDS.SLOW:
				set_speed(SPEEDS.STOPPED)
			elif current_speed == SPEEDS.STOPPED:
				set_speed(SPEEDS.REVERSE)
		else:
			if current_speed == SPEEDS.REVERSE:
				set_speed(SPEEDS.STOPPED)
			elif current_speed == SPEEDS.STOPPED:
				set_speed(SPEEDS.SLOW)
			elif current_speed == SPEEDS.SLOW:
				set_speed(SPEEDS.FAST)
		await get_tree().create_timer(1.3).timeout
		can_change_speed = true

func shoot(index: int, dir : Vector2):
	var cannonball : Node2D = CANNONBALL_RES.instantiate()
	GlobalVariables.sea_view.add_child(cannonball)
	var cannonball_velocity : Vector2
	cannonball.position = position + cannons_offsets[index]
	cannonball.velocity = dir.rotated(lines[index].global_rotation + PI/2.0)
	$GPUParticles2D.position = cannons_offsets[index]
	$GPUParticles2D.process_material.initial_velocity = direction * 100
	$GPUParticles2D.emitting = true
	
