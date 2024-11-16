extends Sprite2D
class_name Collectible


var type : int
var carried := false
var can_be_carried_again := false

func _ready() -> void:
	carry_object()

func deposit_object():
	carried = false
	var gpos := global_position
	get_parent().remove_child(self)
	GlobalVariables.boat_view.add_child(self)
	self.global_position = gpos
	global_scale = Vector2(5, 5)
	can_be_carried_again = false
	await get_tree().create_timer(0.2).timeout
	can_be_carried_again = true

func carry_object():
	carried = true
	#if get_parent() != null:
	#	get_parent().remove_child(self)
	#global_scale = Vector2(5, 5)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not carried and body is PlayerCharacter and can_be_carried_again:
		var pbody : PlayerCharacter = body
		if not pbody.carrying_object:
			get_parent().remove_child(self)
			print("carry new again type = ", type)
			pbody.collect_resource(self, type)
