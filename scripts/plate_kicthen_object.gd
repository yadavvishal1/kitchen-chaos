class_name PlateKitchenObject extends KitchenObject

@onready var kitchen_object_res_array: Array[KitchenObjectsResource] = []

func add_ingredient(_kitchen_object_res: KitchenObjectsResource):
	kitchen_object_res_array.append(kitchen_object_res)
