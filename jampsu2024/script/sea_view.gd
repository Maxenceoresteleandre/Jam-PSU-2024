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
	current_chunk = chunk_pos
	var new_chunks : Array[Vector2i] = []
	for k : Vector2i in chunks.keys():
		if (k.x < current_chunk.x - 1 or k.x > current_chunk.x + 1) or (
			k.y < current_chunk.y - 1 or k.y > current_chunk.y + 1):
			chunks[k].queue_free()
			chunks.erase(k)
		else:
			new_chunks.append(k)
	for x in range(current_chunk.x -1, current_chunk.x + 2):
		for y in range(current_chunk.y -1, current_chunk.y + 2):
			if not (Vector2i(x, y) in new_chunks):
				var c : WorldChunk = spawn_chunk(Vector2i(x, y))
				chunks[Vector2i(x, y)] = c

func spawn_chunk(chunk_coord : Vector2i) -> WorldChunk:
	const CHUNK_PATH := preload("res://scenes/environment/world_chunk.tscn")
	var c := CHUNK_PATH.instantiate()
	add_child(c)
	c.position = chunk_coord * 2000.0
	c.chunk_pos = chunk_coord
	c.connect("player_in_chunk", enter_chunk.bind(c.chunk_pos))
	return c

#func spawn_enemy():
	#const ENEMIES = [
		#preload("res://scenes/characters/ennemies/Shark.tscn"),
		#preload("res://scenes/characters/ennemies/sharklvl2.tscn"),
		#preload("res://scenes/characters/ennemies/Underwater.tscn")
	#]
	#var rd := randi_range(0, 10)
	#if rd <= 5: 
		#spawn_m(ENEMIES[0])
	#elif rd < 9:
		#spawn_m(ENEMIES[1])
	#else:
		#spawn_m(ENEMIES[2])
	#await get_tree().create_timer(randf_range(9.0, 25.0)).timeout
	#spawn_enemy()
#
#func spawn_m(monster : PackedScene):
	#add_child(monster.instantiate())
	#monster.position = $SmallBoat.position + Vector2(randf_range(100.0, 200.0), randf_range(100.0, 200.0))
