extends Sprite2D
class_name Collectible


var type : int
var carried := false

func _ready() -> void:
	carry_object()

func deposit_object():
	carried = false

func carry_object():
	carried = true
	self_modulate = Color.WHITE
