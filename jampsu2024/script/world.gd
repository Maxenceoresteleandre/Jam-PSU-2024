extends Node2D
class_name GameWorld

func _ready() -> void:
	score = 0
	GlobalVariables.world = self
	GlobalVariables.sea_view = $SeaView
	await get_tree().create_timer(0.5).timeout
	spawn_enemy()
	spawn_enemy()
	spawn_enemy()
	spawn_enemy()
	Cutscene.load_cutscene()

static var score := 0
func increase_score():
	score += 1
	$CanvasLayer/Label.text = str(score)
	if score % 15 == 0:
		Cutscene.load_cutscene()

var lifez := 100.0
var can_re := true

func set_life(new_life : float):
	$CanvasLayer/Blood.position.x = 625 + (250 * (new_life / 100))


func spawn_enemy():
	const ENEMIES = [
		preload("res://scenes/characters/ennemies/Shark.tscn"),
		preload("res://scenes/characters/ennemies/sharklvl2.tscn"),
		preload("res://scenes/characters/ennemies/Underwater.tscn"),
		preload("res://scenes/characters/ennemies/kraken.tscn")
	]
	var rd := randi_range(0, 23)
	if rd <= 5 or score <= 10: 
		spawn_m(ENEMIES[0])
	elif rd < 9 or score <= 15:
		spawn_m(ENEMIES[1])
	elif rd <= 20 or score <= 30:
		spawn_m(ENEMIES[2])
	else:
		spawn_m(ENEMIES[3])
	await get_tree().create_timer(randf_range(9.0, 17.0)).timeout
	spawn_enemy()

func spawn_m(monster : PackedScene):
	var m := monster.instantiate()
	$SeaView.add_child(m)
	m.global_position = $SeaView/SmallBoat.global_position + Vector2(randf_range(700.0, 1200.0), randf_range(700.0, 1200.0))
