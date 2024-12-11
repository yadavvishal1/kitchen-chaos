extends Node

@export var label: Label
@export var icon_container:HBoxContainer
@export var icon_template:TextureRect


func set_recipe_res(recipe_res: RecipeRes) -> void:
	label.text = recipe_res.recipe_name

	for child:TextureRect in icon_container.get_children():
		if child == icon_template: continue
		child.queue_free()

	for kitchen_object_res: KitchenObjectsResource in recipe_res.kitchen_object_res_list:
		var icon_template_node:TextureRect  = icon_template.duplicate() as TextureRect
		icon_container.add_child(icon_template_node)
		icon_template_node.texture = kitchen_object_res.icon
