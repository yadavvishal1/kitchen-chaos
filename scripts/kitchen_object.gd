class_name KitchenObject
extends Node3D

@export var kitchen_object_res: KitchenObjectsResource
var kitchen_object: KitchenObject = null

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

static func spawn(kitchen_object_resource: KitchenObjectsResource, kitchen_object_parent: Node3D) -> KitchenObject:
	var new_kitchen_object = kitchen_object_resource.get_scene().instantiate()
	kitchen_object_parent.add_child(new_kitchen_object)
	new_kitchen_object.position = Vector3.ZERO
	return new_kitchen_object
