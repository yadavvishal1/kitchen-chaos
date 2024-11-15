class_name Counter extends StaticBody3D

@export var selected_counter_visual: Node3D
@export var kitchen_object_res: KitchenObjectsResource
@export var second_clear_counter: Counter

var kitchen_object: KitchenObject

func interact() -> void:
	if has_object(): # if counter has an object in slot
		return
	#if counter empty,add kitchen object as new kitchen object
	var new_kitchen_object = kitchen_object_res.scene.instantiate()
	get_node("Slot").add_child(new_kitchen_object)

func select():
	selected_counter_visual.visible = true
	
func deselect():
	selected_counter_visual.visible = false
	
# function to check if Counter has Something in Slot,Return True if it has
func has_object() -> bool:
	return get_node("Slot").get_child_count()>0
	
	
