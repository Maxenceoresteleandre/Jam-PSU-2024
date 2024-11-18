extends InteractibleObject
class_name SteamEngine

const COAL_SPRITE := preload("res://scenes/environment/interactible_objects/CollectibleResource.tscn")
const CANNONBALL_OFFSET := 70.0

const COAL_PLACES : Array[Vector2] = [
	Vector2( -17,  -27),
	Vector2(13,  -27),
	Vector2(-1, -40),
]

const change_speed_rate := 100.0
@onready var coal_reserved : Array[Sprite2D] = []
var can_change_speed := false

func _ready() -> void:
	GlobalVariables.steam_engine = self
	add_coal()
	add_coal()
	add_coal()

func add_resource() -> void:
	add_coal()

func connect_to_player(player : PlayerCharacter):
	return false

func set_can_change_speed_with_delay():
	can_change_speed = false
	await get_tree().create_timer(0.5).timeout
	can_change_speed = true

func interact() -> void:
	pass
	# a boost would be cool but we don't have time

func add_coal() -> bool:
	if coal_reserved.size() >= 3:
		return false
	var new_cannonball : Sprite2D = COAL_SPRITE.instantiate()
	new_cannonball.texture = preload("res://resources/art/boat_view/ship/coal.png")
	self.add_child(new_cannonball)
	coal_reserved.append(new_cannonball)
	new_cannonball.position = COAL_PLACES[coal_reserved.size()-1]
	return true

func consume_coal() -> bool:
	if coal_reserved.size() > 0:
		coal_reserved.pop_back().queue_free()
		return true
	else:
		return false

#func _process(delta: float) -> void:
	#if current_player != null and can_change_speed:
		#var change_speed := 0.0
		#if current_player.down_pressed:
			#change_speed -= 1.0 
		#if current_player.up_pressed:
			#change_speed += 1.0
		#if change_speed > 0.5 or change_speed < -0.5:
			#GlobalVariables.small_boat.set_speed_change(change_speed)
