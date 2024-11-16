extends Node2D

func _ready() -> void:
	var t := create_tween().set_trans(Tween.TRANS_CUBIC)
	t.tween_property($CanvasLayer/ColorRect, "color", Color.TRANSPARENT, 0.4)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		set_process(false)
		var t := create_tween().set_trans(Tween.TRANS_CUBIC)
		t.tween_property($CanvasLayer/ColorRect, "color", Color.BLACK, 0.4)
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://scenes/world.tscn")
