@tool
extends InteractibleObject
class_name Cannon

const CANNONBALL_RES := preload("res://scenes/environment/cannonball_boat.tscn")
const CANNONBALL_SPRITE := preload("res://scenes/environment/interactible_objects/CollectibleResource.tscn")
const CANNONBALL_OFFSET := 70.0

const CANNONBALL_PLACES : Array[Vector2] = [
	Vector2( 97,  18),
	Vector2(137,  18),
	Vector2(117, -10),
]

@export var array_num := 0
@export var turn_speed := 1.0

@export var left_side := true:
	set(value):
		left_side = value
		if left_side:
			scale.x = 1.0
		else:
			scale.x = -1.0

var sea_corresp : Node2D = null

@onready var cannonballs_reserved : Array[Sprite2D] = []

func _ready() -> void:
	create_sea_correspondance()
	add_cannonball()
	add_cannonball()
	add_cannonball()

func add_resource() -> void:
	add_cannonball()

func create_sea_correspondance() -> void:
	pass

func connect_to_player(player : PlayerCharacter):
	GlobalVariables.small_boat.set_line_visibility(array_num, true)
	return super.connect_to_player(player)

func cancel():
	super.cancel()
	GlobalVariables.small_boat.set_line_visibility(array_num, false)

func interact() -> void:
	if cannonballs_reserved.size() == 0:
		return
	# remove cannonball from reserve
	var c : Node = cannonballs_reserved.pop_back()
	c.queue_free()
	# fake cannonball
	var cannonball : Node2D = CANNONBALL_RES.instantiate()
	self.add_child(cannonball)
	var cannonball_velocity : Vector2
	cannonball.position += Vector2.LEFT * CANNONBALL_OFFSET
	cannonball_velocity = Vector2.LEFT
	cannonball.velocity = cannonball_velocity
	# real cannonball
	var orientation : Vector2
	if left_side:
		orientation = Vector2.LEFT
	else:
		orientation = Vector2.RIGHT
	$AudioStreamPlayer.play(0.0)
	GlobalVariables.small_boat.shoot(array_num, orientation)

func add_cannonball() -> bool:
	if cannonballs_reserved.size() >= 3:
		return false
	var new_cannonball : Sprite2D = CANNONBALL_SPRITE.instantiate()
	new_cannonball.texture = preload("res://resources/art/boat_view/ship/cannonball.png")
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
		var orientation : Vector2
		if left_side:
			orientation = Vector2.LEFT
		else:
			orientation = Vector2.RIGHT
		GlobalVariables.small_boat.set_line_direction(array_num, rotation)
