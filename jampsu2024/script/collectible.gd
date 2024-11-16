extends Sprite2D
class_name Collectible


var type : int
var carried := false

func _ready() -> void:
	carry_object()

func deposit_object():
	carried = false
	var gpos := global_position
	get_parent().remove_child(self)
	GlobalVariables.boat_view.add_child(self)
	self.global_position = gpos
	global_scale = Vector2(5, 5)

func carry_object():
	carried = true
	#if get_parent() != null:
	#	get_parent().remove_child(self)
	#global_scale = Vector2(5, 5)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not carried and body is PlayerCharacter:
		var pbody : PlayerCharacter = body
		if not pbody.carrying_object:
			get_parent().remove_child(self)
			pbody.collect_resource(self, type)
