extends Ennemy

# Variables for circular motion
var center: Vector2 # Center of the circle
var radius: float = 100 # Radius of the circle
var angular_speed: float = -1.0 # Speed of movement in radians per second
var angle: float = 90 # Current angle
var rotation_speed: float = -1.0

var can_be_killed = true

func _ready() -> void:
	# Set the center based on the character's starting position
	center = position + Vector2(radius, 0) # Center to the right of the character

func _physics_process(delta: float) -> void:
	if chasing_player:
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
