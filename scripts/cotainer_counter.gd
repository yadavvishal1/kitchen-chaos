extends BaseCounter

signal player_grabbed_object()
@export var kitchen_object_res: KitchenObjectsResource  # The kitchen object resource

func interact(player: Player) -> void:
	if !kitchen_object: 
		if player.picked_object == null:
			var new_kitchen_object = kitchen_object_res.scene.instantiate() # Instantiate the kitchen object
			player.kitchen_object_parent.add_child(new_kitchen_object) # First add it to the counter's parent node
			new_kitchen_object.position = Vector3.ZERO  # Reset position relative to player
			player_grabbed_object.emit()
			kitchen_object = new_kitchen_object  # Store the new kitchen object on the player
			player.picked_object = new_kitchen_object #the the new kitchen player.pickedobject
			kitchen_object_parent = null
			kitchen_object = null
