extends Line2D

var queue: Array[Vector2] = []

func _process(delta: float) -> void:
	var pos = get_parent().global_position
	queue.push_front(pos)
	
	if (len(queue) > 70):
		queue.pop_back()
		
	clear_points()
	
	for point in queue:
		add_point(get_parent().to_local(point))
