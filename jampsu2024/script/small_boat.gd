extends CharacterBody2D
class_name SmallBoat

enum SPEEDS {
	STOPPED = 0,
	SLOW = 40,
	NORMAL = 80,
	FAST = 140
} 

var can_move = true
var max_health = 100.0
var speed: float = 70
@export var current_speed:SPEEDS = SPEEDS.NORMAL
@export var hit_obstacle_min_speed = 50
@export var health: float = max_health
@export var direction: Vector2 = Vector2(1,0)

@export var hit_cooldown_time = 2.0

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

func set_turn(value : float):
	direction = direction.rotated(value)
	$Icon.rotation += value

func damage(damage: float):
	health -= damage
	$Camera2D/CameraUtils.shake(0.3, 7, 20, 2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	print("direction = ", direction)
	pass
	
func _physics_process(_delta: float) -> void:
	$speed_debug.text = "speed : " + str(speed)
	if can_move:
		velocity = direction.normalized() * speed
		move_and_slide()
	if Input.is_action_just_pressed("ui_up"):
		if current_speed == SPEEDS.STOPPED:
			set_speed(SPEEDS.SLOW)
		elif current_speed == SPEEDS.SLOW:
			set_speed(SPEEDS.NORMAL)
		elif current_speed == SPEEDS.NORMAL:
			set_speed(SPEEDS.FAST)
		
	if Input.is_action_just_pressed("ui_down"):
		if current_speed == SPEEDS.FAST:
			set_speed(SPEEDS.NORMAL)
		elif current_speed == SPEEDS.NORMAL:
			set_speed(SPEEDS.SLOW)
		elif current_speed == SPEEDS.SLOW:
			set_speed(SPEEDS.STOPPED)
		

func set_speed(value: SPEEDS):
	current_speed = value
	var t := create_tween().set_trans(Tween.TRANS_CUBIC)
	t.tween_property(self, "speed", value, 2.0)
