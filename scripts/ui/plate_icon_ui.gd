extends Node

@export var plate_kitchen_object: PlateKitchenObject
@export var icon_template:PackedScene



func on_ingredient_added(_kitchen_object_res):
	update_visual()

func update_visual() -> void:
	for child in get_children():
		if child == icon_template: continue
		child.queue_free()
	var kitchen_object_res_array = plate_kitchen_object.get_kitchen_object_res_array()
	for kitchen_object_res in kitchen_object_res_array:
		var icon_template_node = icon_template.instantiate()
		icon_template_node.set_kitchen_object_res(kitchen_object_res)
		add_child(icon_template_node)
