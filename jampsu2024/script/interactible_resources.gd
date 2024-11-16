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
const CRATE_SPRITES := [
	preload("res://resources/art/boat_view/ship/crate_cannonballs.png"),
	preload("res://resources/art/boat_view/ship/coal.png"),
	preload("res://resources/art/boat_view/ship/crate_oil.png")
]

@export var resource : ResourceTypes
@export var can_interact_forever := true

func _ready() -> void:
	var resource_sprite : CollectibleResource = RESOURCES_SPRITE_RES[int(resource)].instantiate()
	self.add_child(resource_sprite)
	$Sprite.texture = CRATE_SPRITES[int(resource)]

func interact() -> void:
	current_player

func connect_to_player(player : PlayerCharacter) -> bool:
	var resource_sprite : CollectibleResource = RESOURCES_SPRITE_RES[int(resource)].instantiate()
	player.collect_resource(resource_sprite, resource)
	if not can_interact_forever:
		remove_res()
	return false

func remove_res():
	await get_tree().process_frame
	queue_free()
