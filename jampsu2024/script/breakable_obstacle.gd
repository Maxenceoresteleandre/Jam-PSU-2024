extends Area2D

func hit():
	$GPUParticles2D.emitting = true
	queue_free()
