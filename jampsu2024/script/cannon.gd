@tool
extends InteractibleObject
class_name Cannon

const CANNONBALL_RES := preload("res://scenes/environment/cannonball_boat.tscn")
const CANNONBALL_SPRITE := preload("res://scenes/environment/cannonball_reserve.tscn")
const CANNONBALL_OFFSET := 70.0

const CANNONBALL_PLACES : Array[Vector2] = [
	Vector2( 97,  18),
	Vector2(137,  18),
	Vector2(117, -10),
]

@export var turn_speed := 1.0

@export var left_side := true:
	set(value):
		left_side = value
		if left_side:
			scale.x = 1.0
		else:
			scale.x = -1.0

var sea_corresp : Node2D = null

@onready var cannonballs_reserved : Array[CollectibleResource] = [$CannonballReserve]

func _ready() -> void:
	create_sea_correspondance()

func create_sea_correspondance() -> void:
	pass

func interact() -> void:
	if cannonballs_reserved.size() == 0:
		return
	# remove cannonball from reserve
	cannonballs_reserved.pop_back().queue_free()
	# fake cannonball
	var cannonball : Node2D = CANNONBALL_RES.instantiate()
	self.add_child(cannonball)
	var cannonball_velocity : Vector2
	cannonball.position += Vector2.LEFT * CANNONBALL_OFFSET
	cannonball_velocity = Vector2.LEFT
	cannonball.velocity = cannonball_velocity
	# real cannonball

func add_cannonball() -> bool:
	if cannonballs_reserved.size() >= 3:
		return false
	var new_cannonball : Sprite2D = CANNONBALL_SPRITE.instantiate()
	self.add_child(new_cannonball)
	cannonballs_reserved.append(new_cannonball)
	new_cannonball.position = CANNONBALL_PLACES[cannonballs_reserved.size()-1]
	return true

func _process(delta: float) -> void:
	if current_player != null and not Engine.is_editor_hint():
		var turn_rate := 0.0
		if current_player.down_pressed or current_player.left_pressed:
			turn_rate += 1.0 
		if current_player.up_pressed or current_player.right_pressed:
			turn_rate -= 1.0
		var rot_offset := turn_speed * delta * turn_rate
		rotation = clamp(rotation + rot_offset, -1.1, 1.1)
