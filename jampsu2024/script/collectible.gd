extends Sprite2D
class_name Collectible

@export var INTERACTIBLE_OBJECT_RES_PATH : Resource

var type : InteractibleResource.ResourceTypes
var carried := false

func deposit_object():
	var obj_res : InteractibleResource = INTERACTIBLE_OBJECT_RES_PATH.instantiate()
	GlobalVariables.boat_view.add_child(obj_res)
	obj_res.global_position = self.global_position
	obj_res.get_node("Sprite").texture = texture
	obj_res.resource = type
	
	queue_free()

func carry_object():
	carried = true
