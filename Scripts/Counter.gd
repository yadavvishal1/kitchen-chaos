class_name Counter extends StaticBody3D

@export var selected_object: Node3D


func interact():
	# Logic to clear the counter
	print("Interact Called")
	print(name)
	# Add your clearing logic here

func select():
	selected_object.visible = true
	
func deselect():
	selected_object.visible = false
