extends CharacterBody3D

@export var move_speed: float = 6.0
@export var rot_speed: float = 10.0
var is_walking: bool = false
@onready var raycast: RayCast3D = $RayCast3D

func _ready() -> void:
	# Connect to the interact_pressed signal from the GameInput script
	GameInput.connect("interact_pressed", Callable(self, "_on_interact_pressed"))

func _on_interact_pressed() -> void:
	handle_interactions()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	handle_movement(delta)

func handle_interactions() -> void:
	if raycast.is_colliding():
		var collided_object = raycast.get_collider()
		var parent_object = collided_object.get_parent()
		
		if parent_object.is_in_group("clear_counters"):
			parent_object.interact()  # Call the interact method
			print("Interacted with ClearCounter")
		else:
			print("No interaction available")
	else:
		print("No object to interact with.")

func handle_movement(delta: float) -> void:
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
