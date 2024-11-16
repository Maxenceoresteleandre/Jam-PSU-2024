extends Ennemy
class_name Shark

@export var speed = 200

func _physics_process(delta: float) -> void:
	if chasing_player:
		velocity = position.direction_to(GlobalVariables.small_boat.position) * speed
		move_and_slide()
