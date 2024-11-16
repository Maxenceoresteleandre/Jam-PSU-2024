extends Ennemy
class_name Shark

@export var player: PackedScene

func _physics_process(delta: float) -> void:
	if chasing_player:
		move_toward(g)
