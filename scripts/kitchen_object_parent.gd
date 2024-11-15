class_name KitchenObjectParent
extends Node

var kitchen_object: KitchenObject = null

signal object_added(kitchen_object: Node)
signal object_removed(kitchen_object: Node)

 #Function to check if the counter has a kitchen object
func has_kitchen_object():
	pass

func set_kitchen_object(new_kitchen_object: KitchenObject) -> void:
	if kitchen_object != null:
		push_error("This KitchenObjectParent already has an object.")
		return

	kitchen_object = new_kitchen_object

func get_kitchen_object():
	return kitchen_object

func clear_kitchen_object() -> void:
	if kitchen_object != null:
		kitchen_object = null  # Clear the reference to the object
