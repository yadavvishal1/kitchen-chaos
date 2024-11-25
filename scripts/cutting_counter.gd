class_name CuttingCounter extends BaseCounter

signal OnprogressChanged(progress_normalized: float)
signal OnCut

@export var cutting_recipe_res_array: Array[CuttingRecipeResource] = []

var _cutting_progress:int = 0

func interact(player: Player) -> void:
	if !kitchen_object:
		if player.picked_object:
			if _has_recipe_with_input(player.picked_object.kitchen_object_res):
				drop_kitchen_object(player)
				_cutting_progress = 0  # Reset progress for the new object

				# Emit progress change with normalized value
				var cutting_recipe_res: CuttingRecipeResource = _get_cutting_recipe_res_with_input(kitchen_object.kitchen_object_res)
				var normalized_progress = float(_cutting_progress) / float(cutting_recipe_res.cutting_progress_max)
				OnprogressChanged.emit(normalized_progress)  # Emit signal with progress

	else:
		if player.picked_object:
			print("Player is Carrying Something")
		else:
			pick_up_kitchen_object(player)


func interact_alternate(_player: Player) -> void:
	if kitchen_object && _has_recipe_with_input(kitchen_object.kitchen_object_res):
		_cutting_progress += 1
		OnCut.emit()
		var cutting_recipe_res: CuttingRecipeResource = _get_cutting_recipe_res_with_input(kitchen_object.kitchen_object_res)
		var normalized_progress = float(_cutting_progress) / float(cutting_recipe_res.cutting_progress_max)
		OnprogressChanged.emit(normalized_progress)  # Emit signal with progress
		if _cutting_progress >= cutting_recipe_res.cutting_progress_max:
			var output_kitchen_object_res = _get_output_for_input(kitchen_object.kitchen_object_res)
			kitchen_object.queue_free()
			kitchen_object = null
			var new_kitchen_object = KitchenObject.spawn(output_kitchen_object_res, kitchen_object_parent)
			kitchen_object = new_kitchen_object  # Store the new kitchen object on the player


func _get_output_for_input(input_kitchen_object_res: KitchenObjectsResource) -> KitchenObjectsResource:
	var cutting_recipe_res: CuttingRecipeResource = _get_cutting_recipe_res_with_input(input_kitchen_object_res)
	if cutting_recipe_res != null:
		return cutting_recipe_res.output
	else:
		return null

func _has_recipe_with_input(input_kitchen_object_res: KitchenObjectsResource) -> bool:
	var cutting_recipe_res: CuttingRecipeResource = _get_cutting_recipe_res_with_input(input_kitchen_object_res)
	return cutting_recipe_res != null


func _get_cutting_recipe_res_with_input(input_kitchen_object_res: KitchenObjectsResource) -> CuttingRecipeResource:
	for cutting_recipe_res in cutting_recipe_res_array:
		if cutting_recipe_res.input == input_kitchen_object_res:
			return cutting_recipe_res

	return null
