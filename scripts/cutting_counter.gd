extends BaseCounter

@export var cutting_recipe_res_array: Array[CuttingRecipeResource] = []

func interact(player: Player) -> void:
	print("Interact Pressed")
	if kitchen_object:
		if player.picked_object == null:
			pick_up_kitchen_object(player)

	elif player.picked_object != null:
		drop_kitchen_object(player)

func interact_alternate(_player: Player) -> void:
	if kitchen_object:
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
