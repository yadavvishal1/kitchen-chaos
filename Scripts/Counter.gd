class_name Counter
extends StaticBody3D

@export var selected_counter_visual: Node3D
@export var kitchen_object_res: KitchenObjectsResource

var kitchen_object: KitchenObject
@onready var kitchen_object_parent: Node3D = $KitchenObjectParent

# Interact with the counter to either spawn, pick, or drop the object
func interact(player: Player) -> void:
	print("Interact Pressed")
	if !has_kitchen_object() and player.picked_object == null:
		 # If there is no kitchen object on the counter, spawn a new one
		var new_kitchen_object = kitchen_object_res.scene.instantiate()  # Create a new kitchen object from the resource
		new_kitchen_object.position = Vector3.ZERO  # Position it at the counter's origin
		set_kitchen_object(new_kitchen_object)  # Set the kitchen object for the counter

	elif has_kitchen_object() and player.picked_object == null:
		pick_up_kitchen_object(player)

	elif player.picked_object != null:
		drop_kitchen_object(player)

## Spawn a new kitchen object on the counter
#func spawn_kitchen_object() -> void:
	#var new_kitchen_object = kitchen_object_res.scene.instantiate()
	#set_kitchen_object(new_kitchen_object)

# Pick up the kitchen object from the counter
func pick_up_kitchen_object(player: Player) -> void:
	var slot = get_node("KitchenObjectParent")  # Reference to the Slot node where the kitchen object is expected to be
	if slot.get_child_count() > 0:
		var object: Node3D = slot.get_child(0)  # Get the first child in the slot
		if object != null:
			object.reparent(player.get_node("KitchenObjectParent"))  # Reparent object to the player's slot
			object.position = Vector3.ZERO  # Reset position relative to the player
			player.picked_object = object as KitchenObject  # Store the picked object reference
			clear_kitchen_object()  # Clear the counter's object
	else:
		print("No kitchen object to pick up from this counter.")


# Drop the object back onto the counter
func drop_kitchen_object(player: Player) -> void:
	set_kitchen_object(player.picked_object)
	player.picked_object.reparent(kitchen_object_parent)
	player.picked_object.position = Vector3.ZERO
	player.picked_object = null

func select():
	selected_counter_visual.visible = true
	
func deselect():
	selected_counter_visual.visible = false
	
# Function to check if the counter has a kitchen object
func has_kitchen_object() -> bool:
	return kitchen_object != null

# Set the kitchen object on the counter
func set_kitchen_object(new_kitchen_object: KitchenObject) -> void:
	if kitchen_object != null:
		push_error("Counter already has a kitchen object.")
		return

	kitchen_object = new_kitchen_object
	kitchen_object_parent.add_child(kitchen_object)  # Add the object to the counter's parent (slot or designated container)
	kitchen_object.position = Vector3.ZERO  # Reset the object's position relative to the counter

func get_kitchen_object():
	return kitchen_object

func clear_kitchen_object() -> void:
	kitchen_object = null
