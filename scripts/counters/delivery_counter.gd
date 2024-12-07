extends BaseCounter

@export var delivery_manager:DeliveryManager

func interact(player: Player):
	if player.picked_object:
		if player.picked_object is PlateKitchenObject: #only accepts plate
			delivery_manager.deliver_recipe(player.picked_object)
			player.picked_object.queue_free()
