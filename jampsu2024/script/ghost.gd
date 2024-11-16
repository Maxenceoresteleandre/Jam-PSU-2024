extends CharacterBody2D
class_name Ghost


func _ready() -> void:
	await get_tree().create_timer(30.0).timeout
	cleanse()

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("stun"):
		body.stun()
		cleanse()

func cleanse():
	velocity = Vector2.ZERO
	$Area2D/CollisionShape2D.disabled = true
	var t := create_tween().set_trans(Tween.TRANS_CUBIC)
	t.tween_property(self, "scale", Vector2.ZERO, 0.5)
	await t.finished
	queue_free()
