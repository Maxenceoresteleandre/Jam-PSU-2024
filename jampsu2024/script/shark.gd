extends Ennemy
class_name Shark


var going_back = false
var random_point := Vector2.ZERO
var rng = RandomNumberGenerator.new()

func _physics_process(delta: float) -> void:
	if going_back and position.distance_squared_to(random_point) < 10:
		going_back = false
		chasing_player = true
	if going_back:
		velocity = position.direction_to(random_point) * speed
		look_at(random_point)
		move_and_slide()
	elif chasing_player:
		velocity = position.direction_to(GlobalVariables.small_boat.position) * speed
		look_at(GlobalVariables.small_boat.position)
		move_and_slide()
		

func _on_hitbox_area_2d_body_entered(body: Node2D) -> void:
	if body is SmallBoat:
		body.ennemy_hit()
		going_back = true
		choose_random_point()

func choose_random_point():
	var rp = Vector2(rng.randi_range(position.x - 500, position.x-200), rng.randi_range(position.y - 500, position.y + 500))
	random_point = rp
