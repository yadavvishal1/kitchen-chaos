class_name BaseCounter
extends StaticBody3D

signal OnAnyObjectPlacedHere(pos: Vector3)

@export var selected_counter_visual: Node3D
#@export var kitchen_object_res: KitchenObjectsResource

var kitchen_object: KitchenObject
@onready var kitchen_object_parent: Node3D = $KitchenObjectParent

# Interact with the counter to either spawn, pick, or drop the object
func interact(_player: Player) -> void:
	pass

func interact_alternate(_player: Player) -> void:
	pass
# Pick up the kitchen object from the counter
func pick_up_kitchen_object(player: Player) -> void:
	if kitchen_object:
		if player.picked_object == null:
			kitchen_object.reparent(player.kitchen_object_parent)  # Reparent object to the player's slot
			kitchen_object.position = Vector3.ZERO  # Reset position relative to the player
			player.set_kitchen_object(kitchen_object)
			kitchen_object = null
		else:
			print("player is already holding an object")
	else:
		print("No kitchen object to pick up from this counter.")

# Drop the object back onto the counter
func drop_kitchen_object(player: Player) -> void:
	if player.picked_object != null and kitchen_object == null:
		var dropped_object = player.picked_object
		dropped_object.reparent(kitchen_object_parent)
		dropped_object.position = Vector3.ZERO
		kitchen_object = dropped_object
		set_kitchen_object(dropped_object)
		player.clear_kitchen_object()

func try_add_counter_object_to_player_plate(player: Player) -> bool:
	if kitchen_object == null:
		return false
	if player.picked_object is PlateKitchenObject:
		var plate_kitchen_object: PlateKitchenObject = player.picked_object as PlateKitchenObject
		if plate_kitchen_object.try_add_ingredient(kitchen_object.kitchen_object_res):
			kitchen_object.queue_free()
			kitchen_object = null
			return true
	return false

func try_add_player_object_to_counter_plate(player: Player) -> bool:
	if player.picked_object == null:
		return false
	if kitchen_object is PlateKitchenObject:
		var plate_kitchen_object: PlateKitchenObject = kitchen_object as PlateKitchenObject
		if plate_kitchen_object.try_add_ingredient(player.picked_object.kitchen_object_res):
			player.picked_object.queue_free()
			player.clear_kitchen_object()
			return true
	return false

func set_kitchen_object(new_kitchen_object: KitchenObject) -> void:
	kitchen_object = new_kitchen_object
	if new_kitchen_object != null:
		OnAnyObjectPlacedHere.emit(new_kitchen_object.global_position)

func spawn(kitchen_object_res: KitchenObjectsResource) -> KitchenObject:
	var new_kitchen_object = kitchen_object_res.scene.instantiate() # Instantiate the kitchen object
	kitchen_object_parent.add_child(new_kitchen_object) # First add it to the counter's parent node
	new_kitchen_object.position = Vector3.ZERO  # Reset position relative to player
	return new_kitchen_object

func select():
	selected_counter_visual.visible = true

func deselect():
	selected_counter_visual.visible = false
