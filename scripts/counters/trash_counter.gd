extends BaseCounter

signal any_object_trashed(pos: Vector3)

func interact(player: Player):
	if player.picked_object:
		player.picked_object.queue_free()
		player.clear_kitchen_object()
		any_object_trashed.emit(self.global_position)
