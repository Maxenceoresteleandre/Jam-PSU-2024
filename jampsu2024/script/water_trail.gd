extends Line2D

@export var parent: Node2D
@export var sub_viewport: SubViewport

var queue: Array[Vector2] = []
var length: float = 0.0
var offset: Vector2i
@export var smallest_tip_width: float = 0.5
@export var largest_tip_width: float = 1.0
@export var distance_at_largest_width = 16 * 6
@export var max_length = 20

func _ready() -> void:
	offset = Vector2i(sub_viewport.size.x / 2, sub_viewport.size.y / 2)

func _process(delta: float) -> void:
	var pos = parent.global_position + Vector2(offset)
	queue.push_back(pos)
	
	if (len(queue) > max_length):
		queue.pop_front()
		
	clear_points()
	
	for i in range(len(queue) - 1):
		length += queue[i].distance_to(queue[i + 1])
		add_point(parent.to_local(queue[i]))
	add_point(parent.to_local(queue[len(queue) - 1]))
	
	var width_value: float = lerpf(smallest_tip_width, largest_tip_width, inverse_lerp(0, distance_at_largest_width, length))
	width_curve.set_point_value(0, width_value)
