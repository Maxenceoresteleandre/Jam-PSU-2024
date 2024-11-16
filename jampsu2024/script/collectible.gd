extends Sprite2D
class_name Collectible


var type : InteractibleResource.ResourceTypes
var carried := false

func deposit_object():
	#var obj_res : InteractibleResource = GlobalVariables.INTERACTIBLE_OBJECT_RES_PATH.instantiate()
	#await get_tree().create_timer(0.2).timeout
	#
	#GlobalVariables.boat_view.add_child(obj_res)
	#await get_tree().create_timer(0.2).timeout
	#
	#obj_res.can_interact_forever = false
	#obj_res.global_position = self.global_position
	#obj_res.get_node("Sprite").texture = texture
	#obj_res.resource = type
	#
	#await get_tree().create_timer(1.0).timeout
	
	InteractibleResource.spawn_res_at_location(self.global_position)
	
	queue_free()

func carry_object():
	carried = true
