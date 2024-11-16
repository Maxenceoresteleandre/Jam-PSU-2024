
extends Line2D

var queue: Array[Vector2]
var offset

func _ready() -> void:
	offset = Vector2i(SubViewport.size.x/2, SubViewport.size.y/2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var length = 0
	var pos: Vector2 = get_parent().global_position + offset
	queue.append(pos)
	if len(queue) > MAX_LENGTH and len(queue) > 2:
		queue.pop_front()
		
	clear_points()
