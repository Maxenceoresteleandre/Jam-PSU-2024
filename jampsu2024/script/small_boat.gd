extends CharacterBody2D

@export var direction: Vector2 = Vector2(1,1)
@export var speed: float = 70.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	velocity = direction * speed
	move_and_slide()