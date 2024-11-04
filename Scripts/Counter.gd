class_name Counter extends StaticBody3D

@export var selected_object: Node3D
@export var kitchen_object: KicthenObjectResource = null
@export var counter_top_point: Node3D

var placed_object = null

func interact():
	print("Interact Called")
	if placed_object == null:
		var object = kitchen_object.model.instantiate()
		add_child(object)
		object.position = counter_top_point.position
		if object.has_method("get_kitchen_object_resource"):
			object.kitchen_object_resource = kitchen_object
			placed_object = kitchen_object
			print("Object placed on counter:", object.kitchen_object_resource.object_name)
		print(name)

func select():
	selected_object.visible = true
	
func deselect():
	selected_object.visible = false
