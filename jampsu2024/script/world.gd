extends Node2D

var score = 0

func _ready() -> void:
	GlobalVariables.sea_view = $SeaView
	GlobalVariables.world = self
	
func increment_score():
	score += 1
	$CanvasLayer/Label.text = str(score)
