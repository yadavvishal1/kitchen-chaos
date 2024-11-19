extends BaseCounter

@export var cut_kicthen_object_res: KitchenObjectsResource

func interact(player: Player) -> void:
	print("Interact Pressed")
	if kitchen_object:
		if player.picked_object == null:
			pick_up_kitchen_object(player)

	elif player.picked_object != null:
		drop_kitchen_object(player)

func interact_alternate(player: Player) -> void:
	if kitchen_object:
		kitchen_object.queue_free()
		kitchen_object = null
		#KitchenObject.spawn(cut_kicthen_object_res, kitchen_object_parent)
		spawn()

# spawn and assign to player for counter conatiner
func spawn() -> void:
	var new_kitchen_object = cut_kicthen_object_res.scene.instantiate() # Instantiate the kitchen object
	kitchen_object_parent.add_child(new_kitchen_object) # First add it to the counter's parent node
	new_kitchen_object.position = Vector3.ZERO  # Reset position relative to player
	kitchen_object = new_kitchen_object  # Store the new kitchen object on the player
