extends CharacterBody2D
class_name Tentacle

const TIME_DOWN := 10.0

var is_up := true

func _process(delta: float) -> void:
	pass

func go_down():
	$Sprite2D.visible = false
	$Timer.start(TIME_DOWN)
	is_up = false

func go_up():
	$Sprite2D.visible = true
	is_up = true

func hit():
	go_down()

func _on_hitbox_area_2d_body_entered(body: Node2D) -> void:
	if body is SmallBoat and is_up:
		body.ennemy_hit()

func _on_timer_timeout() -> void:
	go_up()
