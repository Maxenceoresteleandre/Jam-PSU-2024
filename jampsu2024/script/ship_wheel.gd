extends InteractibleObject
class_name ShipWheel

@export var turn_speed := 1.0

func _process(delta: float) -> void:
	if current_player != null:
		var turn_rate := 0.0
		if current_player.right_pressed:
			turn_rate += 1.0 
		if current_player.left_pressed:
			turn_rate -= 1.0
		GlobalVariables.small_boat.set_turn(turn_speed * delta * turn_rate)
