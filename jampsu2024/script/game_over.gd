extends CanvasLayer

@onready var WORLD := preload("res://scenes/world.tscn")

func _ready() -> void:
	var main_label_font = $TextLabel.get("custom_fonts/font")
	var FinalSize = 800
	var t := create_tween().set_trans(Tween.TRANS_CUBIC)
	t.tween_property(main_label_font, "size", FinalSize, 3)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(WORLD)
