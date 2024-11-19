extends Node2D

var current_state := -1

func _ready() -> void:
	var t := create_tween().set_trans(Tween.TRANS_CUBIC)
	t.tween_property($CanvasLayer/ColorRect, "color", Color(0, 0, 0, 0), 0.4)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") or Input.is_action_just_pressed("clicl") or (
	Input.is_action_just_pressed("right") or Input.is_action_just_pressed("ui_right")):
		current_state += 1
		set_new_screen_state()
	elif Input.is_action_just_pressed("left") or Input.is_action_just_pressed("cancel") or (
	Input.is_action_just_pressed("ui_left")):
		if current_state >= 0:
			current_state -= 1
			set_new_screen_state()


func set_new_screen_state():
		match current_state:
			-1:
				var t := create_tween().set_trans(Tween.TRANS_CUBIC)
				t.tween_property($CanvasLayer/ColorRect, "color", Color.BLACK, 0.4)
				await t.finished
				$CanvasLayer/TextureRect.visible = true
				$CanvasLayer/TextureTuto.visible = false
				t = create_tween().set_trans(Tween.TRANS_CUBIC)
				t.tween_property($CanvasLayer/ColorRect, "color", Color(0, 0, 0, 0), 0.4)
			0:
				$CanvasLayer/TextureTuto/CanvasModulate.visible = false
				$CanvasLayer/TextureTuto/TutoLights.visible = false
				if $CanvasLayer/TextureRect.visible:
					var t := create_tween().set_trans(Tween.TRANS_CUBIC)
					t.tween_property($CanvasLayer/ColorRect, "color", Color.BLACK, 0.4)
					await t.finished
					$CanvasLayer/TextureRect.visible = false
					$CanvasLayer/TextureTuto.visible = true
					t = create_tween().set_trans(Tween.TRANS_CUBIC)
					t.tween_property($CanvasLayer/ColorRect, "color", Color(0, 0, 0, 0), 0.4)
			1:
				$CanvasLayer/TextureTuto/CanvasModulate.visible = true
				$CanvasLayer/TextureTuto/TutoLights.visible = true
				$CanvasLayer/TextureTuto/TutoCannons.visible = false
			2:
				$CanvasLayer/TextureTuto/TutoLights.visible = false
				$CanvasLayer/TextureTuto/TutoCannons.visible = true
				$CanvasLayer/TextureTuto/TutoLightHouse.visible = false
			3:
				$CanvasLayer/TextureTuto/TutoCannons.visible = false
				$CanvasLayer/TextureTuto/TutoLightHouse.visible = true
				$CanvasLayer/TextureTuto/TutoWheel.visible = false
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
