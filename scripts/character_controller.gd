class_name Player
extends CharacterBody3D

@export var move_speed: float = 6.0
@export var rot_speed: float = 10.0

var is_walking: bool = false
var selected_counter: BaseCounter
var picked_object: KitchenObject = null  # The object the player is currently holding

# Add KitchenObjectParent as a property in Player (Composition)
@onready var kitchen_object_parent:Node3D = $KitchenObjectParent

@onready var raycast: RayCast3D = $RayCast3D
@onready var object_slot: Node3D = $KitchenObjectParent  # Slot node where the object will be attached when picked up

func _ready() -> void:
	# Connect to the interact_pressed signal from the GameInput script
	GameInput.connect("interact_pressed", Callable(self, "_on_interact_pressed"))

func _on_interact_pressed() -> void:
	if selected_counter != null:
		selected_counter.interact(self) #interact if there is a Selected Counter


func _physics_process(delta: float) -> void:
	handle_movement(delta)
	handle_interactions()

func handle_interactions() -> void:
	if raycast.is_colliding():
		var counter = raycast.get_collider()
		if counter is BaseCounter:
			counter.select()
			selected_counter = counter
		else:
			selected_counter = null
	else:
		selected_counter = null
	deselect_counter()

# Deselection logic for other counters
func deselect_counter():
	for counter in get_tree().get_nodes_in_group("counters"):
		if counter is BaseCounter:
			if selected_counter != counter:
				counter.deselect()

# Handle player movement based on input
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

func player_has_object() -> bool:
	return picked_object != null
