extends Node2D
class_name BoatView

const GHOST_PATH := preload("res://scenes/environment/interactible_objects/ghost.tscn")

@export var cannons : Array[Cannon] = []
@export var min_time_ghost := 5.0
@export var max_time_ghost := 18.0

@onready var ghost_spawns := [$GhostSpawn.position, 
$GhostSpawn2.position,
$GhostSpawn3.position,
$GhostSpawn4.position,
]



func _ready() -> void:
	GlobalVariables.boat_view = self

func spawn_ghost():
	var ghost := GHOST_PATH.instantiate()
	add_child(ghost)
	ghost.position = ghost_spawns.pick_random()
	await get_tree().create_timer(randf_range(min_time_ghost, max_time_ghost)).timeout
	spawn_ghost()
