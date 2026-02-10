class_name DeliveryManager extends Node

signal OnRecipeSpawned
signal OnRecipeCompleted
signal OnRecipeSuccess
signal OnRecipeFailed

@export var _recipe_list_res: RecipeListRes
var waiting_recipe_res_list: Array[RecipeRes] = []
var spawn_recipe_timer: float
var spawn_recipe_timer_max: float = 4.0
var waiting_recipes_max:int = 4
var successful_recipes_amount:int

func _ready():
	waiting_recipe_res_list.clear()

func _process(delta):
	spawn_recipe_timer -= delta
	if spawn_recipe_timer <= 0.0:
		spawn_recipe_timer = spawn_recipe_timer_max
		if %KitchenManager.IsGamePlaying() and waiting_recipe_res_list.size() < waiting_recipes_max:
			var waiting_recipe_res: RecipeRes = _recipe_list_res.recipe_res_list.pick_random()
			waiting_recipe_res_list.append(waiting_recipe_res)
			OnRecipeSpawned.emit()

func deliver_recipe(plate_kitchen_object: PlateKitchenObject) -> void:
	for i in range(waiting_recipe_res_list.size()):
		var waiting_recipe_res = waiting_recipe_res_list[i]
		if _does_plate_match_recipe(plate_kitchen_object, waiting_recipe_res):
			successful_recipes_amount += 1
			waiting_recipe_res_list.remove_at(i)
			OnRecipeCompleted.emit()
			OnRecipeSuccess.emit()
			return
	OnRecipeFailed.emit()

func _does_plate_match_recipe(plate_kitchen_object: PlateKitchenObject, recipe_res: RecipeRes) -> bool:
	if recipe_res.kitchen_object_res_list.size() != plate_kitchen_object.get_kitchen_object_res_array().size():
		return false
	for recipe_kitchen_object_res: KitchenObjectsResource in recipe_res.kitchen_object_res_list:  # cycling through all ingredients in the recipe
		var ingredient_found: bool = false
		for plate_kitchen_object_res: KitchenObjectsResource in plate_kitchen_object.get_kitchen_object_res_array():  # cycling through all ingredients in the plate
			if plate_kitchen_object_res == recipe_kitchen_object_res: # Ingredients Matches
				ingredient_found = true
				break
		if !ingredient_found: # this recipe was not found on the plate
			return false
	return true

func get_waiting_recipe_res_list() -> Array[RecipeRes]:
	return waiting_recipe_res_list

func get_successful_recipes_amount() -> int:
	return successful_recipes_amount
