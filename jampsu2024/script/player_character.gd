extends CharacterBody2D
class_name PlayerCharacter

@export var control_device = 0

var right_pressed := false
var left_pressed := false
var up_pressed := false
var down_pressed := false
var can_act := true

var current_object : InteractibleObject = null


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

func interact() -> void:
	pass

func cancel() -> void:
	if current_object == null:
		return
	
	current_object = null
