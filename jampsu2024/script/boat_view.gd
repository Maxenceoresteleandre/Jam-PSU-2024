extends Node2D
class_name BoatView

@export var cannons : Array[Cannon] = []


func _ready() -> void:
	GlobalVariables.boat_view = self
