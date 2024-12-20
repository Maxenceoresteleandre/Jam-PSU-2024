extends InteractibleObject
class_name ShipLight


const MAX_LIGHT_DURATION = 30.0

var is_light_on := true

func _ready() -> void:
	$Timer.start(randf_range(-10.0, MAX_LIGHT_DURATION) + MAX_LIGHT_DURATION)
	$Sprite/AnimatedSprite2D.play("default")

func connect_to_player(player : PlayerCharacter) -> bool:
	$Timer.start(MAX_LIGHT_DURATION)
	is_light_on = true
	$PointLight2D.visible = true
	$Area2D/CollisionShape2D.disabled = false
	return false

func _on_timer_timeout() -> void:
	is_light_on = false
	$PointLight2D.visible = false
	$Area2D/CollisionShape2D.disabled = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("cleanse"):
		body.cleanse()
