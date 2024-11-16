extends InteractibleObject
class_name InteractibleResource

enum ResourceTypes {
	Oil,
	Cannonballs,
	Coal
}

const RESOURCES_SPRITE_RES := [
	null,
	preload("res://scenes/environment/cannonball_reserve.tscn"),
	null
]

@export var resource : ResourceTypes
