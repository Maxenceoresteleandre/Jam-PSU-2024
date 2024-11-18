extends CharacterBody2D
class_name Ennemy


@export var speed = 150
@export var health := 1
@export var aggro_range = 2000

var chasing_player = true

func hit():
	health -= 1
	if health > 0:
		hit_anim()
	else:
		GlobalVariables.world.increase_score()
		GlobalVariables.camera_util.shake()
		death_anim()
		await $AnimationPlayer.animation_finished
		queue_free()

func hit_anim():
	$AnimationPlayer.play("hit_effect")

func death_anim():
	$AnimationPlayer.play("death_effect")
