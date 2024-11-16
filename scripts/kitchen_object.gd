class_name KitchenObject
extends Node3D

var kitchen_object: KitchenObject = null

#signal object_added(kitchen_object: Node)
#signal object_removed(kitchen_object: Node)

# Function to check if the counter has a kitchen object
func has_kitchen_object() -> bool:
	return kitchen_object != null

# Set the kitchen object on the counter
func set_kitchen_object(new_kitchen_object: KitchenObject) -> void:
	if has_kitchen_object():
		push_error("Counter already has a kitchen object.")
		return
	kitchen_object = new_kitchen_object

func get_kitchen_object():
	return kitchen_object

func clear_kitchen_object() -> void:
	kitchen_object = null
