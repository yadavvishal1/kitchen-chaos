class_name PlateKitchenObject extends KitchenObject

signal OnIngredientAdded(kitchen_object_res: KitchenObjectsResource)

@export var valid_kitchen_object_res_array: Array[KitchenObjectsResource] = []
var kitchen_object_res_array: Array[KitchenObjectsResource] = []

func try_add_ingredient(_kitchen_object_res: KitchenObjectsResource) -> bool:
	if not valid_kitchen_object_res_array.has(_kitchen_object_res):
		return false
	if kitchen_object_res_array.has(_kitchen_object_res):
		return false
	else:
		kitchen_object_res_array.append(_kitchen_object_res)
		OnIngredientAdded.emit(_kitchen_object_res)
		return true
