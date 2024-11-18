extends Node2D
class_name SeaView


var current_chunk := Vector2i(0, 0)

@onready var chunks := {
	Vector2i(0, 0) : $WorldChunk,
	Vector2i(0, -1) : $WorldChunkTop,
	Vector2i(-1, -1) : $WorldChunkTopLeft,
	Vector2i(1, -1) : $WorldChunkTopRight,
	Vector2i(0, 1) : $WorldChunkBottom,
	Vector2i(-1, 0) : $WorldChunkLeft,
	Vector2i(-1, 1) : $WorldChunkBottomLeft,
	Vector2i(1, 0) : $WorldChunkRight,
	Vector2i(1, 1) : $WorldChunkBottomRight 
}


func _ready() -> void:
	GlobalVariables.sea_view = self
	await get_tree().create_timer(0.5).timeout
	for k : Vector2i in chunks.keys():
		var obj : WorldChunk = chunks[k]
		obj.already_in_chunk = false
		obj.connect("player_in_chunk", enter_chunk.bind(obj.chunk_pos))

func enter_chunk(chunk_pos : Vector2i):
	pass

func spawn_chunk():
	const CHUNK_PATH := preload("res://scenes/environment/world_chunk.tscn")
	

func spawn_enemy():
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
