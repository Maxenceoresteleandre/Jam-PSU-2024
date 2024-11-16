extends Area2D
class_name InteractibleObject

@export var freeze_movement := false
@export var movement_speed_multiplier := 1.0

var current_player : PlayerCharacter = null

func interact(player : PlayerCharacter):
	if current_player != null:
		return
	
