extends BaseCounter

func interact(player: Player):
	if player.picked_object:
		if player.picked_object is PlateKitchenObject: #only accepts plate
			player.picked_object.queue_free()
