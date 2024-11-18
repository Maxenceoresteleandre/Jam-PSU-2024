extends InteractibleObject
class_name ShipWheel

@export var turn_speed := 1.0

var can_change_speed := true

func connect_to_player(player : PlayerCharacter):
	set_can_change_speed_with_delay(0.25)
	return super.connect_to_player(player)

func set_can_change_speed_with_delay(delay : float):
	can_change_speed = false
	await get_tree().create_timer(delay).timeout
	can_change_speed = true

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
		
		if not can_change_speed:
			return
		var change_speed := 0.0
		if current_player.down_pressed:
			change_speed -= 1.0 
		if current_player.up_pressed:
			change_speed += 1.0
		if change_speed > 0.5 or change_speed < -0.5:
			GlobalVariables.small_boat.set_speed_change(change_speed)
			set_can_change_speed_with_delay(0.9)
