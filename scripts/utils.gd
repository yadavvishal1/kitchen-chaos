extends Object

func set_parent(item: Node3D, to:Node3D) -> void:
	item.reparent(to.get_node("KitchenObjectParent"))
	item.global_position  = to.get_node("KitchenObjectParent").global_position
