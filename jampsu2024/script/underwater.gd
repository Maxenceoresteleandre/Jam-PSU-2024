extends Ennemy

# Variables for circular motion
var center: Vector2 # Center of the circle
var radius: float = 100 # Radius of the circle
var angular_speed: float = -1.0 # Speed of movement in radians per second
var angle: float = 90 # Current angle
var rotation_speed: float = -1.0

var can_be_killed = true
var going_back = false
var random_point := Vector2.ZERO
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	# Set the center based on the character's starting position
	center = position + Vector2(radius, 0) # Center to the right of the character

func _physics_process(delta: float) -> void:
	print(str(going_back))
	if going_back and position.distance_squared_to(random_point) < 10:
		going_back = false
		chasing_player = true
	if going_back:
		velocity = position.direction_to(random_point) * speed
		look_at(random_point)
		move_and_slide()
	elif chasing_player:
		go_underwater()
		if position.distance_to(GlobalVariables.small_boat.position) < 300:
			go_to_the_surface()
		velocity = position.direction_to(GlobalVariables.small_boat.position) * speed
		look_at(GlobalVariables.small_boat.position)
		move_and_slide()
	else:
		# Update the angle based on the angular speed
		angle += angular_speed * delta

		# Keep the angle within the range of 0 to 2π for simplicity
		angle = wrapf(angle, 0, TAU) # TAU is 2π in Godot

		# Calculate the new position
		var x = center.x + radius * cos(angle)
		var y = center.y + radius * sin(angle)

		# Update the character's position
		position = Vector2(x, y)
		
		# Rotate the character based on motion or independently
		rotation += rotation_speed * delta
	
func go_underwater():
	can_be_killed = false
	var material = $Sprite.material
	if material and material is ShaderMaterial:
		material.set_shader_parameter("enable", true)
	speed = 700

func go_to_the_surface():
	can_be_killed = true
	var material = $Sprite.material
	if material and material is ShaderMaterial:
		material.set_shader_parameter("enable", false)
	speed = 200
	
func hit():
	if can_be_killed:
		super.hit()
		
func choose_random_point():
	var rp = Vector2(rng.randi_range(position.x - 500, position.x-200), rng.randi_range(position.y - 500, position.y + 500))
	random_point = rp


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body is SmallBoat:
		print("hit body")
		body.ennemy_hit()
		going_back = true
		choose_random_point()
