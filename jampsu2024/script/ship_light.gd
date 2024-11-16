extends InteractibleObject
class_name ShipLight


const MAX_LIGHT_DURATION = 25.0

@onready var light_time := randf_range(MAX_LIGHT_DURATION - 10.0, MAX_LIGHT_DURATION)
var is_light_on := true

func _ready() -> void:
	$Timer.start(light_time)

func connect_to_player(player : PlayerCharacter) -> bool:
	$Timer.start(MAX_LIGHT_DURATION)
	is_light_on = true
	$PointLight2D.visible = true
	return false

func _on_timer_timeout() -> void:
	is_light_on = false
	$PointLight2D.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("cleanse") and is_light_on:
		body.cleanse()
