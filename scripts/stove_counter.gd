class_name StoveCounter extends BaseCounter

signal OnprogressChanged(progress_normalized: float)
signal OnStateChanged(state: State)

enum State {Idle, Frying, Fried, Burned}

@export var frying_recipe_res_array: Array[FryingRecipeResource] = []
@export var burning_recipe_res_array: Array[BurningRecipeResource] = []

var state:State
var _frying_recipe_res: FryingRecipeResource
var _burning_recipe_res: BurningRecipeResource

var frying_timer: float
var burning_timer: float

func _ready() -> void:
	state = State.Idle

func _process(delta) -> void:
	if kitchen_object != null:
		match state:
			State.Idle:
				pass

			State.Frying:
				frying_timer += delta
				var normalized_progress = float(frying_timer) / float(_frying_recipe_res.frying_timer_max)
				OnprogressChanged.emit(normalized_progress)  # Emit signal with progress
				if frying_timer > _frying_recipe_res.frying_timer_max:
					kitchen_object.queue_free()
					var new_kitchen_object:KitchenObject = KitchenObject.spawn(_frying_recipe_res.output, kitchen_object_parent)
					kitchen_object = new_kitchen_object
					print("Object Fried!")
					state = State.Fried
					burning_timer = 0.0
					_burning_recipe_res = _get_burning_recipe_res_with_input(kitchen_object.kitchen_object_res)
					OnStateChanged.emit(state)

			State.Fried:
				burning_timer += delta
				var normalized_progress = float(burning_timer) / float(_burning_recipe_res.burning_timer_max)
				OnprogressChanged.emit(normalized_progress)  # Emit signal with progress
				if burning_timer > _burning_recipe_res.burning_timer_max:
					kitchen_object.queue_free()
					kitchen_object = null
					var new_kitchen_object:KitchenObject = KitchenObject.spawn(_burning_recipe_res.output, kitchen_object_parent)
					kitchen_object = new_kitchen_object
					print("Object Burned!")
					state = State.Burned
					OnStateChanged.emit(state)
					normalized_progress = 0.0
					OnprogressChanged.emit(normalized_progress)

			State.Burned:
				pass

func interact(player: Player) -> void:
	if !kitchen_object:
		if player.picked_object:
			if _has_recipe_with_input(player.picked_object.kitchen_object_res):
				drop_kitchen_object(player)
				_frying_recipe_res = _get_frying_recipe_res_with_input(kitchen_object.kitchen_object_res)
				state = State.Frying
				frying_timer = 0.0
				OnStateChanged.emit(state)
				var normalized_progress = float(frying_timer) / float(_frying_recipe_res.frying_timer_max)
				OnprogressChanged.emit(normalized_progress)  # Emit signal with progress

	else:
		if player.picked_object:
			if player.picked_object is PlateKitchenObject:  # If the player is holding a Plate
				var plate_kitchen_object: PlateKitchenObject = player.picked_object as PlateKitchenObject
				if plate_kitchen_object.try_add_ingredient(kitchen_object.kitchen_object_res):
					kitchen_object.queue_free()
					kitchen_object = null
					state = State.Idle
					OnStateChanged.emit(state)
					var normalized_progress = 0.0
					OnprogressChanged.emit(normalized_progress)  # Emit signal with progress

		else:
			pick_up_kitchen_object(player)
			state = State.Idle
			OnStateChanged.emit(state)
			var normalized_progress = 0.0
			OnprogressChanged.emit(normalized_progress)  # Emit signal with progress

func _get_output_for_input(input_kitchen_object_res: KitchenObjectsResource) -> KitchenObjectsResource:
	var frying_recipe_res: FryingRecipeResource = _get_frying_recipe_res_with_input(input_kitchen_object_res)
	if frying_recipe_res != null:
		return frying_recipe_res.output
	else:
		return null

func _has_recipe_with_input(input_kitchen_object_res: KitchenObjectsResource) -> bool:
	var frying_recipe_res: FryingRecipeResource = _get_frying_recipe_res_with_input(input_kitchen_object_res)
	return frying_recipe_res != null


func _get_frying_recipe_res_with_input(input_kitchen_object_res: KitchenObjectsResource) -> FryingRecipeResource:
	for frying_recipe_res: FryingRecipeResource in frying_recipe_res_array:
		if frying_recipe_res.input == input_kitchen_object_res:
			return frying_recipe_res

	return null

func _get_burning_recipe_res_with_input(input_kitchen_object_res: KitchenObjectsResource) -> BurningRecipeResource:
	for burning_recipe_res: BurningRecipeResource in burning_recipe_res_array:
		if burning_recipe_res.input == input_kitchen_object_res:
			return burning_recipe_res

	return null
