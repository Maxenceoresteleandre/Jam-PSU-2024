extends Sprite2D

const SPEED := 800.0

var time_to_live := 500
var velocity : Vector2

func _process(delta: float) -> void:
	time_to_live -= delta
	if time_to_live <= 0.0:
		queue_free()
	position += velocity * SPEED * delta



func _on_area_2d_body_entered(body: Node2D) -> void:
	if not (body is SmallBoat) and body.has_method("hit"):
		body.hit()
