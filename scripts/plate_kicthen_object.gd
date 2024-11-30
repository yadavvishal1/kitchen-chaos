class_name PlateKitchenObject extends KitchenObject

@onready var kitchen_object_res_array: Array[KitchenObjectsResource] = []

func try_add_ingredient(_kitchen_object_res: KitchenObjectsResource) -> bool:
	if kitchen_object_res in kitchen_object_res_array:
		return false
	else:
		kitchen_object_res_array.append(kitchen_object_res)
		return true
