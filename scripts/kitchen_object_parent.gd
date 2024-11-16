class_name KitchenObjectParent
extends Node

@export var sprite: Sprite3D

var object_name: String
var icon: Texture2D

var kitchen_object_parent: Node3D = null

#func setup(kitchen_object_name: String, object_icon: Texture2D):
	#self.object_name = kitchen_object_name
	##self.icon = icon
	##if icon:
		##sprite.texture = icon  # Assign the icon if available

func set_kitchen_object_parent(new_kitchen_object_parent: Node3D) -> void:
	if new_kitchen_object_parent == null:
		push_error("New kitchen object parent cannot be null.")
		return

	if kitchen_object_parent != null and kitchen_object_parent != new_kitchen_object_parent:
		kitchen_object_parent.clear_kitchen_object()  # Remove this object from the old parent if it's different

	kitchen_object_parent = new_kitchen_object_parent

	if kitchen_object_parent.has_kitchen_object():
		push_error("Kitchen Object Parent already has a Kitchen Object.")
		return

	kitchen_object_parent.set_kitchen_object(self)


func  get_kitchen_object_parent() -> Node3D:
	if kitchen_object_parent == null:
		push_error("Kitchen Object Parent already has a Kitchen Object.")
	return kitchen_object_parent
