extends CharacterBody3D

@export var move_speed: float = 6.0
@export var rot_speed: float = 10.0
var is_walking: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input_vector = GameInput.get_movement_vector_normalized()

	if input_vector.length() > 0:
		var move_dir: Vector3 = Vector3(input_vector.x, 0, input_vector.z).normalized() * move_speed

		# Set the velocity based on input
		velocity = move_dir

		# Rotate the character to face the movement direction if moving
		rotation.y = lerp_angle(rotation.y, atan2(move_dir.x, move_dir.z), delta * rot_speed)
		is_walking = true
	else:
		# No input, stop movement
		velocity = Vector3.ZERO
		is_walking = false

	# Call move_and_slide without any arguments
	move_and_slide()
