extends Area2D
class_name Obstacle

const SPRITES : Array = [
	preload("res://scenes/environment/7.png"),
	preload("res://scenes/environment/8.png"),
	preload("res://scenes/environment/10.png"),
	preload("res://scenes/environment/11.png"),
	preload("res://scenes/environment/13.png"),
	preload("res://scenes/environment/14.png"),
	preload("res://scenes/environment/15.png"),
	preload("res://scenes/environment/16.png"),
	preload("res://resources/art/sea_view/Récifs/Deux récifs.png"),
	preload("res://resources/art/sea_view/Récifs/Gros caillou.png"),
	preload("res://resources/art/sea_view/Récifs/Gros caillou.png2.png"),
	preload("res://resources/art/sea_view/Récifs/Récif droit.png"),
	preload("res://resources/art/sea_view/Récifs/Récif gauche.png")
	
]

@export var randomize_sprite := true

func _ready() -> void:
	if randomize_sprite:
		$Icon.texture = SPRITES.pick_random()

func _on_body_entered(body: Node2D) -> void:
	if body is SmallBoat:
		body.hit_obstacle()
