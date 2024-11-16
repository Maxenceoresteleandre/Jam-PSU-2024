extends CharacterBody2D
class_name Ennemy


@export var speed = 100
@export var health := 1
@export var aggro_range = 2000

var chasing_player = false

func _init() -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is SmallBoat:
		chasing_player = true

func hit():
	health -= 1
	if health > 0:
		hit_anim()
	else:
		death_anim()
		await $AnimationPlayer.animation_finished
		queue_free()

func hit_anim():
	$AnimationPlayer.play("hit_effect")

func death_anim():
	$AnimationPlayer.play("death_effect")
