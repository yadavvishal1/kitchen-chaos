class_name KitchenObjectsResource
extends Resource

@export var object_name: String
@export_file("*.tscn") var scene
@export var icon: Texture2D

# You can add a function to get the PackedScene when needed
func get_scene() -> PackedScene:
	return load(scene) as PackedScene
