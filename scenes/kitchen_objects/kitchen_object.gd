extends Node3D
class_name KitchenObject

@export var kitchen_object_resource: KicthenObjectResource # Reference to the KitchenObjectResource


#Getter method for accessing the resource
func get_kitchen_object_resource() -> KicthenObjectResource:
	return kitchen_object_resource
