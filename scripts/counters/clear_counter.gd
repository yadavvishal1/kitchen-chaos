extends BaseCounter

func interact(player: Player) -> void:
	if kitchen_object:  # Check if there is a kitchen object on the counter
		if player.picked_object != null:  # Player is carrying something
			if try_add_counter_object_to_player_plate(player):
				return
			if try_add_player_object_to_counter_plate(player):
				return
		else:
			pick_up_kitchen_object(player)
			# Handle logic for when the player is not carrying anything (not defined in your C# snippet)
	else:
		if player.picked_object != null:  # Player is carrying something and the counter has no kitchen object
			drop_kitchen_object(player)
		else:
			print("Player not carrying anything, and counter is empty")
