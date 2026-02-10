extends Node

@export var kitchen_object_parent: KitchenObjectParent
@export var plate_visual_scene: PackedScene

@onready var plate_visual_game_object_list: Array = []


func _on_plate_spawned():
	var plate_visual:Node3D = plate_visual_scene.instantiate()
	var plate_offset_y: float = 0.1  # You can adjust this offset
	plate_visual.position = Vector3(0, plate_offset_y * plate_visual_game_object_list.size(), 0)
	kitchen_object_parent.add_child(plate_visual)
	plate_visual_game_object_list.append(plate_visual)


func _on_plates_counter_on_plate_removed():
	var plate_game_object: Node3D = plate_visual_game_object_list[plate_visual_game_object_list.size() - 1]
	plate_visual_game_object_list.erase(plate_game_object)
	plate_game_object.queue_free()
