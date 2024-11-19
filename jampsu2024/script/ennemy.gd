extends CharacterBody2D
class_name Ennemy

var DESPAWN_DISTANCE := 2500 * 2500


@export var speed = 150
@export var health := 1

var chasing_player = true
var going_back = false
var random_point := Vector2.ZERO
var rng = RandomNumberGenerator.new()


func check_distance():
	if global_position.distance_squared_to(GlobalVariables.small_boat.global_position) > (
	DESPAWN_DISTANCE):
		queue_free()

func _physics_process(delta: float) -> void:
	#$Sprite.global_rotation = 0.0
	if velocity.x < -1:
		$Sprite.flip_h = true
	elif velocity.x > 1:
		$Sprite.flip_h = false
	if going_back and position.distance_squared_to(random_point) < 10:
		going_back = false
		chasing_player = true
	if going_back:
		velocity = position.direction_to(random_point) * speed
		#look_at(random_point)
		move_and_slide()
	elif chasing_player:
		velocity = position.direction_to(GlobalVariables.small_boat.position) * speed
		#look_at(GlobalVariables.small_boat.position)
		move_and_slide()

func hit():
	health -= 1
	if health > 0:
		hit_anim()
	else:
		speed = 0
		GlobalVariables.world.increase_score()
		death_anim()
		await $AnimationPlayer.animation_finished
		queue_free()

func _on_hitbox_area_2d_body_entered(body: Node2D) -> void:
	if body is SmallBoat:
		body.ennemy_hit()
		going_back = true
		choose_random_point()

func choose_random_point():
	var rp = Vector2(rng.randi_range(position.x - 500, position.x-200), rng.randi_range(position.y - 500, position.y + 500))
	random_point = rp

func hit_anim():
	$AnimationPlayer.play("hit_effect")

func death_anim():
	$AnimationPlayer.play("death_effect")
