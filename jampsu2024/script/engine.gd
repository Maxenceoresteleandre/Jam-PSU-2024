extends InteractibleObject
class_name SteamEngine

const COAL_SPRITE := preload("res://scenes/environment/interactible_objects/CollectibleResource.tscn")
const CANNONBALL_OFFSET := 70.0

const COAL_PLACES : Array[Vector2] = [
	Vector2( 97,  18),
	Vector2(137,  18),
	Vector2(117, -10),
]

const change_speed_rate := 100.0
@onready var coal_reserved : Array[Sprite2D] = []

func _ready() -> void:
	create_sea_correspondance()
	add_coal()

func add_resource() -> void:
	add_coal()

func create_sea_correspondance() -> void:
	pass

func interact() -> void:
	pass
	# a boost would be cool but we don't have time

func add_coal() -> bool:
	if coal_reserved.size() >= 3:
		return false
	var new_cannonball : Sprite2D = COAL_SPRITE.instantiate()
	new_cannonball.texture = preload("res://resources/art/boat_view/ship/coal.png")
	self.add_child(new_cannonball)
	coal_reserved.append(new_cannonball)
	new_cannonball.position = COAL_PLACES[coal_reserved.size()-1]
	return true

func _process(delta: float) -> void:
	if current_player != null and not Engine.is_editor_hint():
		var change_speed := 0.0
		if current_player.down_pressed or current_player.left_pressed:
			change_speed += 1.0 
		if current_player.up_pressed or current_player.right_pressed:
			change_speed -= 1.0
		GlobalVariables.small_boat.set_speed_change(change_speed)
