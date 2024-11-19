extends Node2D

func _physics_process(delta: float) -> void:
	var cursor_position = get_global_mouse_position()
	position = cursor_position
