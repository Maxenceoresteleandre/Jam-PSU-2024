extends Sprite2D

const SPEED := 800.0

var time_to_live := 500
var velocity : Vector2

func _process(delta: float) -> void:
	time_to_live -= delta
	if time_to_live <= 0.0:
		queue_free()
	position += velocity * SPEED * delta
