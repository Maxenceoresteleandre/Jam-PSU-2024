extends InteractibleObject
class_name LightHouse

const OIL_SPRITE := preload("res://scenes/environment/interactible_objects/CollectibleResource.tscn")
const CANNONBALL_OFFSET := 70.0

const OIL_PLACES : Array[Vector2] = [
	Vector2( 97,  18),
	Vector2(137,  18),
	Vector2(117, -10),
]

const change_speed_rate := 100.0
@onready var OIL_reserved : Array[Sprite2D] = []
var can_change_speed := false

func _ready() -> void:
	GlobalVariables.light_house = self
	add_OIL()
	add_OIL()
	add_OIL()

func add_resource() -> void:
	add_OIL()

func connect_to_player(player : PlayerCharacter):
	set_can_change_speed_with_delay()
	return super.connect_to_player(player)

func set_can_change_speed_with_delay():
	can_change_speed = false
	await get_tree().create_timer(0.5).timeout
	can_change_speed = true

func interact() -> void:
	pass
	# a boost would be cool but we don't have time

func add_OIL() -> bool:
	if OIL_reserved.size() >= 3:
		return false
	var new_cannonball : Sprite2D = OIL_SPRITE.instantiate()
	new_cannonball.texture = preload("res://resources/art/boat_view/ship/oil_res.png")
	self.add_child(new_cannonball)
	OIL_reserved.append(new_cannonball)
	new_cannonball.position = OIL_PLACES[OIL_reserved.size()-1]
	return true

func consume_OIL() -> bool:
	if OIL_reserved.size() > 0:
		OIL_reserved.pop_back().queue_free()
		return true
	else:
		return false

func _process(delta: float) -> void:
	if current_player != null and can_change_speed:
		var change_speed := 0.0
		if current_player.down_pressed or current_player.left_pressed:
			change_speed -= 1.0 
		if current_player.up_pressed or current_player.right_pressed:
			change_speed += 1.0
		if change_speed > 0.5 or change_speed < -0.5:
			GlobalVariables.small_boat.set_speed_change(change_speed)
