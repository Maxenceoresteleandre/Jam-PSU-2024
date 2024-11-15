extends CharacterBody2D
class_name PlayerCharacter

@export var control_device = 0

func _input(event: InputEvent) -> void:
	if event.device == control_device:
		pass
	
	
