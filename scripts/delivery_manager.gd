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
		if %KitchenManager.IsgamePlaying() and waiting_recipe_res_list.size() < waiting_recipes_max:
			var waititng_recipe_res: RecipeRes = _recipe_list_res.recipe_res_list.pick_random()
			waiting_recipe_res_list.append(waititng_recipe_res)
			OnRecipeSpawned.emit()

func deliver_recipe(plate_kitchen_object: PlateKitchenObject) -> void:
	for i in range(waiting_recipe_res_list.size()):
		var waititng_recipe_res = waiting_recipe_res_list[i]
		if waititng_recipe_res.kitchen_object_res_list.size() == plate_kitchen_object.get_kitchen_object_res_array().size(): #has same number of ingredients
			var plate_contents_matches_recipe:bool =  true
			for recipe_kitchen_object_res: KitchenObjectsResource in waititng_recipe_res.kitchen_object_res_list:  # cycling through all ingradient in the recipe
				var ingrdient_found:bool =  false
				for plate_kitchen_object_res: KitchenObjectsResource in plate_kitchen_object.get_kitchen_object_res_array():  # cycling through all ingradient in the plate
					if plate_kitchen_object_res == recipe_kitchen_object_res: # Ingredients Matches
						ingrdient_found = true
						break
				if !ingrdient_found: # this recipe was not found on the plate
					plate_contents_matches_recipe = false
			if plate_contents_matches_recipe: #player delivered correct recipe
				successful_recipes_amount += 1
				waiting_recipe_res_list.remove_at(i)
				OnRecipeCompleted.emit()
				OnRecipeSuccess.emit()
				return

		OnRecipeFailed.emit()

func get_waiting_recipe_res_list() -> Array[RecipeRes]:
	return waiting_recipe_res_list

func get_successful_recipes_amount() -> int:
	return successful_recipes_amount
