extends BaseCounter

func interact(player: Player):
	if player.picked_object:
		player.picked_object.queue_free()
