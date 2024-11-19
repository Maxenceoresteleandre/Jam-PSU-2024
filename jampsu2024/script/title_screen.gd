extends Node2D

var current_state := 0

func _ready() -> void:
	var t := create_tween().set_trans(Tween.TRANS_CUBIC)
	t.tween_property($CanvasLayer/ColorRect, "color", Color.TRANSPARENT, 0.4)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") or Input.is_action_just_pressed("clicl"):
		match current_state:
			0:
				var t := create_tween().set_trans(Tween.TRANS_CUBIC)
				t.tween_property($CanvasLayer/ColorRect, "color", Color.BLACK, 0.4)
				await t.finished
				$CanvasLayer/TextureRect.visible = false
				$CanvasLayer/TextureTuto.visible = true
				t = create_tween().set_trans(Tween.TRANS_CUBIC)
				t.tween_property($CanvasLayer/ColorRect, "color", Color.TRANSPARENT, 0.4)
			1:
				$CanvasLayer/TextureTuto/TutoLights.visible = true
			2:
				$CanvasLayer/TextureTuto/CanvasModulate.visible = true
				$CanvasLayer/TextureTuto/TutoLights.visible = false
				$CanvasLayer/TextureTuto/TutoCannons.visible = true
			3:
				$CanvasLayer/TextureTuto/TutoCannons.visible = false
				$CanvasLayer/TextureTuto/TutoLightHouse.visible = true
			4:
				$CanvasLayer/TextureTuto/TutoLightHouse.visible = false
				$CanvasLayer/TextureTuto/TutoWheel.visible = true
			5:
				$CanvasLayer/TextureTuto/CanvasModulate.visible = false
				$CanvasLayer/TextureTuto/TutoWheel.visible = false
			6:
				set_process(false)
				var t := create_tween().set_trans(Tween.TRANS_CUBIC)
				t.tween_property($CanvasLayer/ColorRect, "color", Color.BLACK, 0.4)
				await t.finished
				get_tree().change_scene_to_file("res://scenes/world.tscn")
		current_state += 1
