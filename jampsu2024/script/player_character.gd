extends CharacterBody2D
class_name PlayerCharacter

@export var control_device := 0
@export var player_color := Color.WHITE
@export var speed := 200

var right_pressed := false
var left_pressed := false
var up_pressed := false
var down_pressed := false

var can_move := false
var can_act := false

var current_object : InteractibleObject = null
var nearby_object : InteractibleObject = null

var object_freeze_movement := false
var object_speed_coeff := 1.0


func _ready() -> void:
	start_game()
	$WhitePixel.modulate = player_color

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

func _physics_process(_delta: float) -> void:
	if can_move and not object_freeze_movement:
		velocity = Vector2(int(right_pressed) - int(left_pressed), int(down_pressed) - int(up_pressed)
		).normalized() * speed * object_speed_coeff
		check_turn()
		move_and_slide()

func check_turn() -> void:
	if velocity.x > 0.1:
		$Sprite.flip_h = true
	elif velocity.x < -0.1:
		$Sprite.flip_h = false

func interact() -> void:
	print("player " + str(control_device) + " interact!")
	if current_object == null:
		interact_with_new_object()
		if current_object == null:
			interact_idle()
			print("\twith nothing")
			return
	current_object.interact()
	print("\twith object " + str(current_object))

func interact_idle() -> void:
	return

func interact_with_new_object() -> void:
	if nearby_object == null:
		return
	if nearby_object.connect_to_player(self):
		current_object = nearby_object
		object_freeze_movement = nearby_object.freeze_movement
		object_speed_coeff = nearby_object.movement_speed_multiplier

func cancel() -> void:
	if current_object == null:
		return
	
	object_freeze_movement = false
	object_speed_coeff = 1.0
	current_object = null

func leave_interaction_zone(object : InteractibleObject) -> void:
	nearby_object = null

func _on_interaction_area_area_entered(area: Area2D) -> void:
	if area is InteractibleObject:
		var ibody : InteractibleObject = area
		ibody.enter_interact_zone(self)
		if nearby_object != null:
			nearby_object.leave_interact_zone(self)
		nearby_object = ibody

func _on_interaction_area_area_exited(area: Area2D) -> void:
	if area == nearby_object:
		nearby_object.leave_interact_zone(self)
		nearby_object = null
