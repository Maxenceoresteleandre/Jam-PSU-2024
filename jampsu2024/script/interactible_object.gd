extends Area2D
class_name InteractibleObject

@export var freeze_movement := false
@export var movement_speed_multiplier := 1.0

var current_player : PlayerCharacter = null

func interact(player : PlayerCharacter) -> bool:
	if current_player != null:
		return false
	current_player = player
	return true

func cancel() -> void:
	current_player = null
