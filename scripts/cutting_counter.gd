extends BaseCounter

@export var cut_kicthen_object_res: KitchenObjectsResource

func interact(player: Player) -> void:
	print("Interact Pressed")
	if kitchen_object:
		if player.picked_object == null:
			pick_up_kitchen_object(player)

	elif player.picked_object != null:
		drop_kitchen_object(player)

func interact_alternate(_player: Player) -> void:
	if kitchen_object:
		kitchen_object.queue_free()
		kitchen_object = null
		var new_kitchen_object = KitchenObject.spawn(cut_kicthen_object_res, kitchen_object_parent)
		kitchen_object = new_kitchen_object  # Store the new kitchen object on the player
