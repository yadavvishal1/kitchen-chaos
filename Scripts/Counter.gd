class_name Counter
extends StaticBody3D

@export var selected_counter_visual: Node3D
@export var kitchen_object_res: KitchenObjectsResource

var kitchen_object: KitchenObject
@onready var kitchen_object_parent: Node3D = $KitchenObjectParent

# Interact with the counter to either spawn, pick, or drop the object
func interact(player: Player) -> void:
	print("Interact Pressed")
	if !kitchen_object and player.picked_object == null:
		spawn_kitchen_object()

	elif kitchen_object and player.picked_object == null:
		pick_up_kitchen_object(player)

	elif player.picked_object != null:
		drop_kitchen_object(player)

# Spawn a new kitchen object on the counter
func spawn_kitchen_object() -> void:
	var new_kitchen_object = kitchen_object_res.scene.instantiate()
	new_kitchen_object.position = Vector3.ZERO
	new_kitchen_object.set_kitchen_object(new_kitchen_object)
	kitchen_object = new_kitchen_object  # Store the new kitchen object on the counter
	kitchen_object_parent.add_child(kitchen_object)  # Add the new object to the parent

# Pick up the kitchen object from the counter
func pick_up_kitchen_object(player: Player) -> void:
	if kitchen_object:
		kitchen_object.reparent(player.kitchen_object_parent)  # Reparent object to the player's slot
		kitchen_object.position = Vector3.ZERO  # Reset position relative to the player
		player.picked_object = kitchen_object  # Store the picked object reference
		print(kitchen_object.get_parent().get_parent().name, ": has kitchen object!", )
		kitchen_object = null
	else:
		print("No kitchen object to pick up from this counter.")

# Drop the object back onto the counter
func drop_kitchen_object(player: Player) -> void:
	if player.picked_object != null and !kitchen_object:
		var dropped_object = player.picked_object
		dropped_object.reparent(kitchen_object_parent)
		dropped_object.position = Vector3.ZERO
		kitchen_object = dropped_object
		player.picked_object = null

func select():
	selected_counter_visual.visible = true
	
func deselect():
	selected_counter_visual.visible = false
