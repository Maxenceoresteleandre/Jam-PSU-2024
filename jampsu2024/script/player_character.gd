extends CharacterBody2D
class_name PlayerCharacter

@export var control_device := 0
@export var speed := 200

var right_pressed := false
var left_pressed := false
var up_pressed := false
var down_pressed := false

var can_move := false
var can_act := false

var current_object : InteractibleObject = null
var nearby_objects : Array[InteractibleObject] = []


func start_game():
	can_move = true
	can_act = true

func _input(event: InputEvent) -> void:
	if event.device == control_device:
		if event.is_action_pressed("right"):
			right_pressed = true
		elif event.is_action_released("right"):
			right_pressed = false
		if event.is_action_pressed("left"):
			left_pressed = true
		elif event.is_action_released("left"):
			left_pressed = false
		if event.is_action_pressed("up"):
			up_pressed = true
		elif event.is_action_released("up"):
			up_pressed = false
		if event.is_action_pressed("down"):
			down_pressed = true
		elif event.is_action_released("down"):
			down_pressed = false
			set_collision_mask_value(5, true)
	
	if can_act:
		if event.is_action_pressed("interact"):
			interact()
		elif event.is_action_pressed("cancel"):
			cancel()
	
	if can_move:
		velocity = Vector2(int(right_pressed) - int(left_pressed), int(down_pressed) - int(up_pressed)) * speed
		move_and_slide()

func interact() -> void:
	if current_object == null:
		interact_with_new_object()
	current_object.interact()

func interact_with_new_object() -> void:
	for obj : InteractibleObject in nearby_objects:
		if obj.connect_to_player(self):
			current_object = obj
			break

func cancel() -> void:
	if current_object == null:
		return
	
	current_object = null
