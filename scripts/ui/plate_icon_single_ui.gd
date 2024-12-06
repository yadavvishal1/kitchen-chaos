extends PanelContainer

@export var texture_rect: TextureRect

# Called when the node enters the scene tree for the first time.
func set_kitchen_object_res(kitchen_object_res: KitchenObjectsResource):
	texture_rect.texture = kitchen_object_res.icon
