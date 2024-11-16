extends Sprite2D
class_name CollectibleResource


var type : InteractibleResource.ResourceTypes
var carried := false

func deposit_object():
	carried = false

func carry_object():
	carried = true
