extends Node2D

func _ready() -> void:
	var t := create_tween().set_trans(Tween.TRANS_CUBIC)
	t.tween_property($CanvasLayer/ColorRect, "color", Color.TRANSPARENT, 0.4)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		get_tree().change_scene_to_file("res://scenes/world.tscn")
