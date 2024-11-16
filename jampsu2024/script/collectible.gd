extends Sprite2D
class_name Collectible


var type : int
var carried := false
var can_be_carried_again := false

var potential_player : PlayerCharacter = null

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

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not carried and body is PlayerCharacter and potential_player == null:
		potential_player = body
		potential_player.connect("interacting_with_nothing", potential_carry_back)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == potential_player:
		potential_player.disconnect("interacting_with_nothing", potential_carry_back)
		potential_player = null

func potential_carry_back():
	if not potential_player.carrying_object:
		potential_player.collect_resource(self, type)
