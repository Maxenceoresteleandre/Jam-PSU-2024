extends CanvasLayer

func _ready() -> void:
	$TextScore.text = str(GameWorld.score)
