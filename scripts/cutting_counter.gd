extends BaseCounter

@export var cutting_recipe_res_array: Array[CuttingRecipeResource] = []

func interact(player: Player) -> void:
	if !kitchen_object:
		if player.picked_object:
			if _has_recipe_with_input(player.picked_object.kitchen_object_res):
				drop_kitchen_object(player)
	else:
		if player.picked_object:
			print("Player is Carrying Something")
		else:
			pick_up_kitchen_object(player)


func interact_alternate(_player: Player) -> void:
	if kitchen_object && _has_recipe_with_input(kitchen_object.kitchen_object_res):
		var output_kitchen_object_res = _get_output_for_input(kitchen_object.kitchen_object_res)
		kitchen_object.queue_free()
		kitchen_object = null
		var new_kitchen_object = KitchenObject.spawn(output_kitchen_object_res, kitchen_object_parent)
		kitchen_object = new_kitchen_object  # Store the new kitchen object on the player


func _get_output_for_input(input_kitchen_object_res: KitchenObjectsResource) -> KitchenObjectsResource:
	for cutting_recipe_res in cutting_recipe_res_array:
		if cutting_recipe_res.input == input_kitchen_object_res:
			return cutting_recipe_res.output

	return null

func _has_recipe_with_input(input_kitchen_object_res: KitchenObjectsResource) -> bool:
	for cutting_recipe_res in cutting_recipe_res_array:
		if cutting_recipe_res.input == input_kitchen_object_res:
			return true

	return false
