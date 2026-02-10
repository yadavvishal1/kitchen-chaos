class_name Player
extends CharacterBody3D

signal OnPickedSomething(pos: Vector3)

@export var move_speed: float = 6.0
@export var rot_speed: float = 10.0

var is_walking: bool = false
var selected_counter: BaseCounter
var picked_object: KitchenObject = null  # The object the player is currently holding

# Add KitchenObjectParent as a property in Player (Composition)
@onready var kitchen_object_parent:Node3D = $KitchenObjectParent
@onready var raycast: RayCast3D = $RayCast3D
@onready var object_slot: Node3D = $KitchenObjectParent  # Slot node where the object will be attached when picked up
@onready var kitchen_manager = %KitchenManager

func _ready() -> void:
	# Connect to the interact_pressed signal from the GameInput script
	GameInput.connect("interact_pressed", Callable(self, "_on_interact_pressed"))
	GameInput.connect("interact_alternate_pressed", Callable(self, "_on_interact_alternate_pressed"))

func _on_interact_pressed() -> void:
	if !kitchen_manager.IsGamePlaying():return
	if is_instance_valid(selected_counter):
		selected_counter.interact(self) #interact if there is a Selected Counter

func _on_interact_alternate_pressed() -> void:
	if !kitchen_manager.IsGamePlaying():return
	if is_instance_valid(selected_counter):
		selected_counter.interact_alternate(self) #interact if there is a Selected Counter

func _physics_process(delta: float) -> void:
	handle_movement(delta)
	handle_interactions()

func handle_interactions() -> void:
	var new_selected_counter: BaseCounter = null
	if raycast.is_colliding():
		var counter = raycast.get_collider()
		if counter is BaseCounter:
			new_selected_counter = counter
	if new_selected_counter != selected_counter:
		if is_instance_valid(selected_counter):
			selected_counter.deselect()
		if new_selected_counter != null:
			new_selected_counter.select()
		selected_counter = new_selected_counter

# Handle player movement based on input
func handle_movement(delta: float) -> void:
	var input_vector = GameInput.get_movement_vector_normalized()
	if not input_vector.is_zero_approx():
		var move_dir: Vector3 = Vector3(input_vector.x, 0, input_vector.z) * move_speed

		# Set the velocity based on input
		velocity = move_dir

		# Rotate the character to face the movement direction if moving
		rotation.y = lerp_angle(rotation.y, atan2(move_dir.x, move_dir.z), delta * rot_speed)

	else:
		# No input, stop movement
		velocity = Vector3.ZERO
	# Call move_and_slide without any arguments
	move_and_slide()
	is_walking = velocity.length_squared() > 0.01  # Update is_walking based on actual movement
	if is_on_floor() and velocity.is_zero_approx():
		is_walking = false

func get_kitchen_object() -> KitchenObject:
	return picked_object

func set_kitchen_object(new_picked_object: KitchenObject) -> void:
	picked_object =  new_picked_object
	if new_picked_object != null:
		OnPickedSomething.emit(global_position)

func clear_kitchen_object() -> void:
	picked_object = null
