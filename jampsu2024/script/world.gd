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

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func cut_music():
	var t := create_tween()
	t.tween_property($AudioStreamPlayer, "volume_db", -80.0, 0.5)

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

func set_speed(new_speed : int):
	const ROT_VALS_FROM_SPEED := {
		-100 : -27.0, 
		0: 0.0, 
		100: 24.2, 
		140: 47.8
	}
	var next_speed_rot_val : float = ROT_VALS_FROM_SPEED[new_speed]
	var t := create_tween().set_trans(Tween.TRANS_CUBIC)
	t.tween_property($CanvasLayer/TextureLever, "rotation_degrees", next_speed_rot_val, 1.0)
	$CanvasLayer/AudioStreamLever.play()

func set_flames_height(flames_height : float):
	$CanvasLayer/Flames.position.y = 50 - flames_height * 50.0

func spawn_enemy():
	const ENEMIES = [
		preload("res://scenes/characters/ennemies/Shark.tscn"),
		preload("res://scenes/characters/ennemies/sharklvl2.tscn"),
		preload("res://scenes/characters/ennemies/Underwater.tscn"),
		preload("res://scenes/characters/ennemies/kraken.tscn"),
		preload("res://scenes/characters/ennemies/shark_no_light.tscn")
	]
	var rd := randi_range(0, 23)
	if rd <= 10 or score <= 10: 
		if randi()%2 == 0:
			spawn_m(ENEMIES[0])
		else:
			spawn_m(ENEMIES[4])
	elif rd < 15 or score <= 15:
		spawn_m(ENEMIES[1])
	elif rd <= 20 or score <= 30:
		spawn_m(ENEMIES[2])
	else:
		spawn_m(ENEMIES[3])
	await get_tree().create_timer(randf_range(9.0, 9.0)).timeout
	spawn_enemy()

func spawn_m(monster : PackedScene):
	var m := monster.instantiate()
	$SeaView.add_child(m)
	m.global_position = $SeaView/SmallBoat.global_position + Vector2.RIGHT.rotated(
		randf_range(0.0, 6.3)) * randf_range(1000, 1000)
