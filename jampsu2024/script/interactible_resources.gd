extends InteractibleObject
class_name InteractibleResource

enum ResourceTypes {
	Oil,
	Cannonballs,
	Coal
}

const RESOURCES_SPRITE_RES := [
	preload("res://resources/art/boat_view/ship/oil_res.png"),
	preload("res://resources/art/boat_view/ship/cannonball.png"),
	preload("res://resources/art/boat_view/ship/coal.png")
]
const COLLECTIBLE_RESOURCE_PATH := preload("res://scenes/environment/interactible_objects/CollectibleResource.tscn")
const CRATE_SPRITES := [
	preload("res://resources/art/boat_view/ship/crate_cannonballs.png"),
	preload("res://resources/art/boat_view/ship/crate_coal.png"),
	preload("res://resources/art/boat_view/ship/crate_oil.png")
]

@export var collect_res : Resource
@export var resource : ResourceTypes
@export var can_interact_forever := true

func _ready() -> void:
	var resource_sprite = collect_res.instantiate()
	self.add_child(resource_sprite)
	print("resource_sprite : ", resource_sprite)
	#resource_sprite.texture = RESOURCES_SPRITE_RES[int(resource)]
	
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
