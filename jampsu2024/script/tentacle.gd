@tool
extends CharacterBody2D
class_name Tentacle

const TIME_DOWN := 10.0
const MIN_SPEED := 20.0
const MAX_SPEED := 60.0

var speed := 60.0

@export var tentacle_texture : Texture = preload("res://resources/art/sea_view/kraken/tentacule 01.png"):
	set(value):
		tentacle_texture = value
		$Sprite2D.texture = tentacle_texture

var is_up := true
@onready var origin := position
@onready var target = set_new_obj_point()

func _ready() -> void:
	await get_tree().create_timer(randf_range(0.0, 1.0)).timeout
	$AnimatedSprite2D.play("default")

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return
	move_and_slide()
	if position.distance_squared_to(target) < 100.0:
		target = set_new_obj_point()

func set_new_obj_point() -> Vector2:
	speed = randf_range(MIN_SPEED, MAX_SPEED)
	var v : Vector2 = origin + Vector2(
		randf_range(-100, 100),
		randf_range(-100, 100)
	) 
	velocity = position.direction_to(v) * speed
	if velocity.x > 1:
		$Sprite2D.flip_h = false
	elif velocity.x < -1:
		$Sprite2D.flip_h = true
	return v

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
