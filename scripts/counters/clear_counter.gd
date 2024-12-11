extends BaseCounter

func interact(player: Player) -> void:
	if kitchen_object:  # Check if there is a kitchen object on the counter
		if player.picked_object != null:  # Player is carrying something
			if player.picked_object is PlateKitchenObject:  # If the player is holding a Plate
				var plate_kitchen_object: PlateKitchenObject = player.picked_object as PlateKitchenObject
				if plate_kitchen_object.try_add_ingredient(kitchen_object.kitchen_object_res):
					kitchen_object.queue_free()
					kitchen_object = null
			else:
				if kitchen_object is PlateKitchenObject:  # If the player is holding a Plate
					var plate_kitchen_object: PlateKitchenObject = kitchen_object as PlateKitchenObject
					if plate_kitchen_object.try_add_ingredient(player.picked_object.kitchen_object_res):
						player.picked_object.queue_free()
		else:
			pick_up_kitchen_object(player)
			# Handle logic for when the player is not carrying anything (not defined in your C# snippet)
	else:
		if player.picked_object != null:  # Player is carrying something and the counter has no kitchen object
			drop_kitchen_object(player)
		else:
			print("Player not carrying anything, and counter is empty")
