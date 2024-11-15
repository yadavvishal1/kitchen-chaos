class_name KitchenObject
extends Node

#@export var kitchen_object_res: KitchenObjectsResource
var clear_counter: Counter

# Getter for KitchenObjectSO
#func get_kitchen_object_res() -> KitchenObjectsResource:
	#return kitchen_object_res

# Setter for ClearCounter
func set_clear_counter(new_clear_counter: Counter) -> void:
	self.clear_counter = new_clear_counter

# Getter for ClearCounter
func get_clear_counter() -> Counter:
	return clear_counter
