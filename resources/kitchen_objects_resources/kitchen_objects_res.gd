class_name KitchenObjectsResource
extends Resource

@export var object_name: String
@export var scene: PackedScene
@export var icon: Texture2D

func instantiate_object() -> Node3D:
	var kitchen_object = scene.instantiate()  # Instantiate the object from the scene
	kitchen_object.setup(object_name, icon)  # Set the name and icon externally
	return kitchen_object
