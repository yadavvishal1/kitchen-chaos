extends BaseCounter

# Assuming kitchen_object is a reference to the object on the counter
# Assuming player.picked_object is the object the player is currently holding

func interact(player: Player) -> void:
	print("Interact Pressed")
	
	if kitchen_object:  # Check if there is a kitchen object on the counter
		if player.picked_object != null:  # Player is carrying something
			if player.picked_object is PlateKitchenObject:  # If the player is holding a Plate
				var plate_kitchen_object: PlateKitchenObject = player.picked_object as PlateKitchenObject
				if plate_kitchen_object.try_add_ingredient(kitchen_object.kitchen_object_res):
					kitchen_object.queue_free()
			else:
				# Handle other objects the player might be carrying
				drop_kitchen_object(player)
		else:
			print("Player is not carrying anything")
			# Handle logic for when the player is not carrying anything (not defined in your C# snippet)
	else:
		if player.picked_object != null:  # Player is carrying something and the counter has no kitchen object
			drop_kitchen_object(player)
		else:
			print("Player not carrying anything, and counter is empty")
