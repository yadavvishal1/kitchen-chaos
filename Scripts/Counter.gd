class_name Counter extends StaticBody3D

@export var selected_object: Node3D
@export var kitchen_object: KitchenObjects
@export var counter_top_point: Node3D

var has_object: bool = false

func interact() -> void:
	print("Interact Called")
	if kitchen_object != null && has_object == false:
		var object = kitchen_object.scene.instantiate()
		add_child(object)
		object.position = counter_top_point.position
		has_object = true

func select():
	selected_object.visible = true
	
func deselect():
	selected_object.visible = false
