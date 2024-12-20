extends CharacterBody2D
class_name PlayerCharacter

signal interacting_with_nothing

const INTERACT_DELAY = 0.1
const PLAYER_ANIMS : Array[String] = [
	"amaranth",
	"ivory",
	"obsidian",
	"yellow"
]

@export var anim_num := 0
@export var control_device := 0
@export var player_color := Color.WHITE
@export var speed := 320

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
var carrying_object := false
var resource_type : int
var carried_object : Collectible = null


func _ready() -> void:
	start_game()
	$Sprite.play(PLAYER_ANIMS[anim_num])
	$Sprite.speed_scale = 0.0
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
		if velocity.length_squared() > 100:
			$Sprite.speed_scale = 1.0
		else:
			$Sprite.speed_scale = 0.0
		check_turn()
		move_and_slide()

func check_turn() -> void:
	if velocity.x > 0.1:
		$Sprite.flip_h = true
	elif velocity.x < -0.1:
		$Sprite.flip_h = false

func stun():
	var nsm := false
	if can_move or can_act:
		nsm = true
	stun_act()
	stun_walk()
	if nsm:
		modulate = Color(100, 0, 0)
		await get_tree().create_timer(2.75).timeout
		modulate = Color.WHITE

func stun_walk():
	if not can_move:
		return
	can_move = false
	await get_tree().create_timer(3.0).timeout
	can_move = true

func stun_act():
	if not can_act:
		return
	can_act = false
	await get_tree().create_timer(3.0).timeout
	can_act = true

func interact() -> void:
	print("player " + str(control_device) + " interact!")
	if carrying_object:
		print("\t carrying")
		if nearby_object != null:
			print("\t\tnearby_object.consume_resource_type = ", nearby_object.consume_resource_type, " ; int(resource_type) = ", int(resource_type))
			if nearby_object.consume_resource_type == int(resource_type):
				print("\t\t\tgood resource")
				nearby_object.add_resource()
				leave_resource(true)
		else:
			leave_resource()
		return
	if current_object == null:
		interact_with_new_object()
		if current_object == null:
			interact_idle()
		start_interact_delay()
		return
	current_object.interact()

func collect_resource(obj : Collectible, rtype : int):
	if carrying_object:
		return
	print("collect : ", obj, " of type ", rtype)
	resource_type = rtype
	carried_object = obj
	carried_object.carry_object()
	carrying_object = true
	object_speed_coeff = 0.7
	if carried_object.get_parent() != null:
		carried_object.get_parent().remove_child(carried_object)
	self.add_child(carried_object)
	carried_object.global_position = $ObjectAttach.global_position
	carried_object.global_scale = Vector2(5, 5)

func leave_resource(delete_obj := false):
	carrying_object = false
	if delete_obj:
		carried_object.queue_free()
	else:
		carried_object.type = resource_type
		carried_object.deposit_object()
	carried_object = null
	object_speed_coeff = 1.0
	

func start_interact_delay():
	can_act = false
	await get_tree().create_timer(INTERACT_DELAY).timeout
	can_act = true

func interact_idle() -> void:
	emit_signal("interacting_with_nothing")

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
	current_object.cancel()
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
