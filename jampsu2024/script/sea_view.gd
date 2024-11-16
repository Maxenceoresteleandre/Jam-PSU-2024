extends Node2D
class_name SeaView




func _ready() -> void:
	GlobalVariables.sea_view = self
	print(GlobalVariables.sea_view)


func spawn_enemy():
	print("hello")
	const ENEMIES = [
		preload("res://scenes/characters/ennemies/Shark.tscn"),
		preload("res://scenes/characters/ennemies/sharklvl2.tscn"),
		preload("res://scenes/characters/ennemies/Underwater.tscn")
	]
	var rd := randi_range(0, 10)
	if rd <= 5: 
		spawn_m(ENEMIES[0])
	elif rd < 9:
		spawn_m(ENEMIES[1])
	else:
		spawn_m(ENEMIES[2])
	await get_tree().create_timer(randf_range(9.0, 25.0)).timeout
	spawn_enemy()

func spawn_m(monster : PackedScene):
	add_child(monster.instantiate())
	monster.position = $SmallBoat.position + Vector2(randf_range(100.0, 200.0), randf_range(100.0, 200.0))
