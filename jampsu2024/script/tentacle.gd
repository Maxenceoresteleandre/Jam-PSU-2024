extends CharacterBody2D
class_name Tentacle


func _process(delta: float) -> void:
	pass

func go_down():
	$Sprite2D.visible = false

func go_up():
	$Sprite2D.visible = true

func hit():
	go_down()

func _on_hitbox_area_2d_body_entered(body: Node2D) -> void:
	if body is SmallBoat:
		body.ennemy_hit()
