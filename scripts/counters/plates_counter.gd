extends BaseCounter

signal OnPlateSpawned
signal OnplateRemoved

@export var plate_kitchen_object_res: KitchenObjectsResource
var spawn_plate_timer:float
var spawn_plate_timer_max: float = 4.0
var plates_spawned_amount: int
var plates_spawned_amount_max: int = 4

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawn_plate_timer += delta
	if spawn_plate_timer > spawn_plate_timer_max:
		spawn_plate_timer = 0.0

		if plates_spawned_amount < plates_spawned_amount_max:
			plates_spawned_amount += 1
			OnPlateSpawned.emit()

func interact(player: Player) -> void:
	if !player.picked_object:
		if plates_spawned_amount > 0:
			plates_spawned_amount -= 1
			var new_kicthen_object = KitchenObject.spawn(plate_kitchen_object_res, player.kitchen_object_parent)
			player.picked_object = new_kicthen_object
			OnplateRemoved.emit()
