extends Area2D
class_name InteractibleObject

@export var freeze_movement := false
@export var movement_speed_multiplier := 1.0

var current_player : PlayerCharacter = null
var in_player_interact_zone : PlayerCharacter = null

func interact() -> void:
	pass

func enter_interact_zone(player : PlayerCharacter) -> bool:
	if current_player != null:
		return false
	if in_player_interact_zone != null:
		leave_interact_zone(player, false)
	in_player_interact_zone = player
	return true

func leave_interact_zone(player : PlayerCharacter, remove_shader := true) -> void:
	player.leave_interaction_zone(self)
	in_player_interact_zone = null
	if remove_shader:
		$Sprite.material.set_shader_parameter("width", 0.0)

func connect_to_player(player : PlayerCharacter) -> bool:
	if current_player != null:
		return false
	current_player = player
	return true

func cancel() -> void:
	current_player = null
