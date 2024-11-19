extends Node2D
class_name BoatView

const GHOST_PATH := preload("res://scenes/environment/interactible_objects/ghost.tscn")

@export var cannons : Array[Cannon] = []
@export var min_time_ghost := 5.0
@export var max_time_ghost := 15.0

@onready var ghost_spawns := [$GhostSpawn.position, 
$GhostSpawn2.position,
$GhostSpawn3.position,
$GhostSpawn4.position,
]

var current_water_time := 0.0
var water_time_scale := 0.7



func _ready() -> void:
	GlobalVariables.boat_view = self
	spawn_ghost()

func _process(delta: float) -> void:
	current_water_time += delta * water_time_scale
	$water.material.set_shader_parameter("time", current_water_time)

func set_water_movement(speed : float):
	water_time_scale = speed / 100.0

func spawn_ghost():
	var ghost := GHOST_PATH.instantiate()
	add_child(ghost)
	ghost.position = ghost_spawns.pick_random()
	ghost.velocity = (ghost.global_position.direction_to($LightOccluder2D.global_position) ).normalized() * 400.0
	await get_tree().create_timer(randf_range(min_time_ghost, max_time_ghost)).timeout
	spawn_ghost()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Ghost and body.velocity.x > 1:
		body.cleanse()
