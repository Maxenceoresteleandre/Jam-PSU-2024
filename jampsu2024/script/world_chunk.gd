extends Node2D


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
