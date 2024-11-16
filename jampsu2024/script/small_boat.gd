extends CharacterBody2D
class_name SmallBoat

var can_move = true
var max_health = 100.0
@export var health: float = max_health
@export var direction: Vector2 = Vector2(1,1)
@export var speed: float = 70.0
@export var hit_cooldown_time = 2.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$health_debug.text = str(health) + "/" + str(max_health)

func hit_obstacle():
	damage(10)
	can_move = false
	velocity = Vector2.ZERO  # TODO: rendre l'arrêt moins brutal ?
	await get_tree().create_timer(hit_cooldown_time).timeout
	can_move = true
	$health_debug.text = str(health) + "/" + str(max_health)

func damage(damage: float):
	health -= damage

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if can_move:
		velocity = direction * speed
		move_and_slide()
