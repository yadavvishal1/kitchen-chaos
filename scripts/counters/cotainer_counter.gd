extends BaseCounter

signal player_grabbed_object()
@export var kitchen_object_res: KitchenObjectsResource  # The kitchen object resource

func interact(player: Player) -> void:
	if !kitchen_object: 
		if player.picked_object == null:
			var new_kitchen_object = KitchenObject.spawn(kitchen_object_res, player.kitchen_object_parent)
			player_grabbed_object.emit()
			player.set_kitchen_object(new_kitchen_object)
