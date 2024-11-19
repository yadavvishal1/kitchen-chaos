extends BaseCounter


func interact(player: Player) -> void:
	print("Interact Pressed")
	if kitchen_object:
		if player.picked_object == null:
			pick_up_kitchen_object(player)

	elif player.picked_object != null:
		drop_kitchen_object(player)
