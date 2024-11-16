@tool
extends InteractibleObject
class_name Cannon

const CANNONBALL_RES := preload("res://scenes/environment/cannonball_boat.tscn")
const CANNONBALL_OFFSET := 70.0

@export var turn_speed := 1.0

@export var left_side := true:
	set(value):
		left_side = value
		$Sprite.flip_h = not left_side

var sea_corresp : Node2D = null

func _ready() -> void:
	create_sea_correspondance()

func create_sea_correspondance() -> void:
	pass

func interact() -> void:
	var cannonball : Node2D = CANNONBALL_RES.instantiate()
	self.add_child(cannonball)
	var cannonball_velocity : Vector2
	if left_side:
		cannonball.position += Vector2.LEFT * CANNONBALL_OFFSET
		cannonball_velocity = Vector2.LEFT
	else:
		cannonball.position += Vector2.RIGHT * CANNONBALL_OFFSET
		cannonball_velocity = Vector2.RIGHT
	cannonball.velocity = cannonball_velocity

func _process(delta: float) -> void:
	if current_player != null:
		var turn_rate := 0.0
		if current_player.down_pressed or current_player.left_pressed:
			turn_rate += 1.0 
		if current_player.up_pressed or current_player.right_pressed:
			turn_rate -= 1.0
		var rot_offset := turn_speed * delta * turn_rate
		rotation = clamp(rotation + rot_offset, -1.1, 1.1)
