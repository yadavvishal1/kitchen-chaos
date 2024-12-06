extends Node3D

@export var kitchen_object_res_kitchen_object_list: Array[KitchenObjectResKitchenObject]

@export var plate_kitchen_object: PlateKitchenObject


func on_ingredient_added(_kitchen_object_res):
	for kitchen_object_res_kitchen_object in kitchen_object_res_kitchen_object_list:
		if kitchen_object_res_kitchen_object.kitchen_object_res == _kitchen_object_res:
			#print("Toggling visibility for:", kitchen_object.name)
			get_node(kitchen_object_res_kitchen_object.kitchen_object).visible = true
