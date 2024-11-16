extends Node2D
class_name SeaView

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalVariables.sea_view = self
	print(GlobalVariables.sea_view)
