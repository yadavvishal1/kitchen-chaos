extends Control

@export var container: VBoxContainer
@export var recipe_template: PackedScene
@onready var delivery_manager: DeliveryManager = %DeliveryManager

func _ready() -> void:
	update_visual()

func update_visual() -> void:
	for child in container.get_children():
		if child == recipe_template: continue
		child.queue_free()

	for recipe_res: RecipeRes in delivery_manager.get_waiting_recipe_res_list():
		var recipe_node = recipe_template.instantiate()
		container.add_child(recipe_node)
		recipe_node.set_recipe_res(recipe_res)


func _on_delivery_manager_on_recipe_spawned():
	update_visual()


func _on_delivery_manager_on_recipe_completed():
	update_visual()
