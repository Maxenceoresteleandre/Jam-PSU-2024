extends InteractibleObject
class_name InteractibleResource

enum ResourceTypes {
	Oil,
	Cannonballs,
	Coal
}

const RESOURCES_SPRITE_RES := [
	preload("res://scenes/environment/oil_reserve.tscn"),
	preload("res://scenes/environment/cannonball_reserve.tscn"),
	preload("res://scenes/environment/coal_reserve.tscn")
]

@export var resource : ResourceTypes

func _ready() -> void:
	var resource_sprite : Sprite2D = RESOURCES_SPRITE_RES[int(resource)].instantiate()
	self.add_child(resource_sprite)

func interact() -> void:
	current_player

func connect_to_player(player : PlayerCharacter) -> bool:
	
	return false
