extends Area2D
class_name Obstacle

func _on_body_entered(body: Node2D) -> void:
	if body is SmallBoat:
		body.hit_obstacle()
