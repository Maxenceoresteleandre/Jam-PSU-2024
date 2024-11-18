extends Area2D

func hit():
	$Icon/AnimatedSprite2D.play("default")
	await(get_tree().create_timer(0.5)).timeout
	queue_free()
