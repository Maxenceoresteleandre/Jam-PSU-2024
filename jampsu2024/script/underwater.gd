extends Ennemy

func _physics_process(delta: float) -> void:
	if chasing_player:
		go_underwater()
		if position.distance_to(GlobalVariables.small_boat.position) < 300:
			go_to_the_surface()
	
func go_underwater():
	speed = 700

func go_to_the_surface():
	speed = 200
