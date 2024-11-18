extends CanvasLayer

func _ready() -> void:
	$TextScore.text = str(GameWorld.score)


func _on_button_pressed() -> void:
	GameWorld.score = 0
	get_tree().change_scene_to_file("res://scenes/world.tscn")
