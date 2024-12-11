extends BaseCounter

signal OnAnyObjectTrashed(pos: Vector3)

func interact(player: Player):
	if player.picked_object:
		player.picked_object.queue_free()
		OnAnyObjectTrashed.emit(self.global_position)
