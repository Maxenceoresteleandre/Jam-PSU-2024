extends Area2D
class_name InteractibleObject

const MAX_WIDTH_OUTLINE := 10.0

@export var freeze_movement := false
@export var movement_speed_multiplier := 1.0

var current_player : PlayerCharacter = null
var in_player_interact_zone : PlayerCharacter = null
var outline_width := 0.0
var tween_outline := false

func interact() -> void:
	pass

func _process(_delta: float) -> void:
	if tween_outline:
		$Sprite.material.set_shader_parameter("width", outline_width)

func enter_interact_zone(player : PlayerCharacter) -> bool:
	if current_player != null:
		return false
	$Sprite.material.set_shader_parameter("color", player.player_color)
	if in_player_interact_zone != null:
		leave_interact_zone(player, false)
	else:
		tween_outline_to(MAX_WIDTH_OUTLINE)
	in_player_interact_zone = player
	return true

func leave_interact_zone(player : PlayerCharacter, remove_shader := true) -> void:
	player.leave_interaction_zone(self)
	if player == in_player_interact_zone:
		in_player_interact_zone = null
		if remove_shader:
			tween_outline_to(0.0)

func tween_outline_to(to_val : float):
	tween_outline = true
	var tween := create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "outline_width", to_val, 0.5)
	await tween.finished
	tween_outline = false

func connect_to_player(player : PlayerCharacter) -> bool:
	if current_player != null:
		return false
	current_player = player
	return true

func cancel() -> void:
	current_player = null
