extends Line2D

var queue: Array[Vector2] = []
var length: float = 0.0
@export var smallest_tip_width = 6
@export var largest_tip_width = 15
@export var distance_at_largest_width = 16 * 6

func _process(delta: float) -> void:
	var pos = get_parent().get_parent().get_parent().get_parent().global_position
	queue.push_front(pos)
	
	if (len(queue) > 10):
		queue.pop_back()
		
	clear_points()
	
	for i in range(len(queue) - 1):
		length += queue[i].distance_to(queue[i + 1])
		add_point(get_parent().get_parent().get_parent().get_parent().to_local(queue[i]))

	var width_value: float = lerp(smallest_tip_width, largest_tip_width, inverse_lerp(0, distance_at_largest_width, length))
	width_curve.set_point_value(0, width_value)
