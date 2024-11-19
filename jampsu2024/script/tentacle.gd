@tool
extends CharacterBody2D
class_name Tentacle

const TIME_DOWN := 10.0

@export var tentacle_texture : Texture = preload("res://resources/art/sea_view/kraken/tentacule 01.png"):
	set(value):
		tentacle_texture = value
		$Sprite2D.texture = tentacle_texture

var is_up := true

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return

func go_down():
	is_up = false
	$AnimationPlayer.play("hit")
	await $AnimationPlayer.animation_finished
	$Sprite2D.visible = false
	$Timer.start(TIME_DOWN)

func go_up():
	$Sprite2D.visible = true
	is_up = true

func hit():
	if is_up:
		go_down()

func _on_hitbox_area_2d_body_entered(body: Node2D) -> void:
	if body is SmallBoat and is_up:
		body.ennemy_hit()

func _on_timer_timeout() -> void:
	go_up()
