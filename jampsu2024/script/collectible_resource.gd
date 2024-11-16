extends Sprite2D
class_name CollectibleResource

const INTERACTIBLE_OBJECT_RES_PATH = preload("res://scenes/environment/interactible_objects/interactible_resources.tscn")

var type : InteractibleResource.ResourceTypes
var carried := false

func deposit_object():
	var obj_res : InteractibleObjectResource = INTERACTIBLE_OBJECT_RES_PATH.instantiate()
	GlobalVariables.boat_view.add_child(obj_res)
	obj_res.global_position = self.global_position
	obj_res.set_obj_sprite(texture)
	obj_res.resource = type
	
	queue_free()

func carry_object():
	carried = true
