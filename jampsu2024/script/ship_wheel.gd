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
		var rot_offset := turn_speed * delta * turn_rate
		GlobalVariables.small_boat.set_turn(rot_offset)
		$Sprite/Sprite2.rotation += rot_offset
