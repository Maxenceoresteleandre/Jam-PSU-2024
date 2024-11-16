@tool
extends InteractibleObject
class_name Cannon

const CANNONBALL_RES := preload("res://scenes/environment/cannonball_boat.tscn")
const CANNONBALL_OFFSET := 70.0

@export var turn_speed := 1.0

@export var left_side := true:
	set(value):
		left_side = value
		if left_side:
			scale.x = 1.0
		else:
			scale.x = -1.0

var sea_corresp : Node2D = null

func _ready() -> void:
	create_sea_correspondance()

func create_sea_correspondance() -> void:
	pass

func interact() -> void:
	# fake cannonball
	var cannonball : Node2D = CANNONBALL_RES.instantiate()
	self.add_child(cannonball)
	var cannonball_velocity : Vector2
	cannonball.position += Vector2.LEFT * CANNONBALL_OFFSET
	cannonball_velocity = Vector2.LEFT
	cannonball.velocity = cannonball_velocity
	# real cannonball

func _process(delta: float) -> void:
	if current_player != null:
		var turn_rate := 0.0
		if current_player.down_pressed or current_player.left_pressed:
			turn_rate += 1.0 
		if current_player.up_pressed or current_player.right_pressed:
			turn_rate -= 1.0
		var rot_offset := turn_speed * delta * turn_rate
		rotation = clamp(rotation + rot_offset, -1.1, 1.1)
