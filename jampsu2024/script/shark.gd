extends Ennemy
class_name Shark

@export var speed = 200

func _physics_process(delta: float) -> void:
	if chasing_player:
		velocity = position.direction_to(GlobalVariables.small_boat.position) * speed
		move_and_slide()
		

func _on_hitbox_area_2d_body_entered(body: Node2D) -> void:
	if body is SmallBoat:
		body.ennemy_hit()
		$HitboxArea2D.monitoring = false
		await get_tree().create_timer(2.0).timeout
		$HitboxArea2D.monitoring = true
		
		
