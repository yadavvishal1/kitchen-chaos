extends BaseCounter

func interact(player: Player) -> void:
	print("Interact Pressed")

	# Case 1: The counter is empty (no kitchen object)
	if kitchen_object == null:
		if player.picked_object == null:
			pass  # Player is not carrying anything, so nothing happens
		else:
			drop_kitchen_object(player)

# Case 2: The counter has a kitchen object
	else:
		if player.picked_object == null:
			pick_up_kitchen_object(player)

		elif kitchen_object == null:
			Utils.set_parent(player.picked_object, self)
			#player.picked_object.reparent(self.get_node("KitchenObjectParent"))
			kitchen_object.global_position = kitchen_object.get_parent().global_position
			player.picked_object = null
		else:
			# Player is carrying something, check if it's the correct Plate
			if player.picked_object is PlateKitchenObject:
				kitchen_object.reparent(player.picked_object.get_node("KitchenObjectSlot"))
				kitchen_object.global_position = kitchen_object.get_parent().global_position
				var plate_kitchen_object = player.picked_object as PlateKitchenObject
				plate_kitchen_object.add_ingredient(kitchen_object.kitchen_object_res)
				print("Player is holding a Plate")

			else:
				pass # Player is carrying something else, do nothing or handle other cases
