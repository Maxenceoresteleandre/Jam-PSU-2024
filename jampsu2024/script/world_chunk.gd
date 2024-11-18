extends Node2D
class_name WorldChunk

signal player_in_chunk

@export var already_in_chunk := false
@export var chunk_pos : Vector2i

func _ready() -> void:
	var nb_rocks := randi_range(10, 15)
	for _i in range(nb_rocks):
		spawn_rock()

func spawn_rock():
	const OBSTACLES = [
		preload("res://scenes/environment/Obstacle.tscn"),
		preload("res://scenes/environment/large_obstacle.tscn"),
		preload("res://scenes/environment/BreakableObstacle.tscn")
	]
	var rd := randi_range(0, 15)
	var r 
	if rd <= 9: 
		r = (OBSTACLES[0])
	elif rd < 12:
		r = (OBSTACLES[1])
	else:
		r = (OBSTACLES[2])
	var m : Node2D = r.instantiate()
	self.add_child(m)
	m.position = Vector2(
		randf_range(-900.0, 900.0),
		randf_range(-900.0, 900.0)
	)


func _on_enter_area_2d_body_entered(body: Node2D) -> void:
	if body is SmallBoat and not already_in_chunk:
		emit_signal("player_in_chunk")
