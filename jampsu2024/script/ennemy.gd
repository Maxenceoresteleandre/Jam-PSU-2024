extends CharacterBody2D
class_name Ennemy

@export var aggro_range = 2000
var chasing_player = false

func _init() -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	chasing_player = true
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	chasing_player = false
