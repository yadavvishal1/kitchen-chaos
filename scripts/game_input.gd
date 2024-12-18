extends Node

# Declare the signal
signal interact_pressed()
signal interact_alternate_pressed()
signal on_pause_action()

const keymaps_path = "user://keymaps.dat"
var keymaps: Dictionary

func _ready() -> void:
	# First we create the keymap dictionary on startup with all
	# the keymap actions we have.
	for action in InputMap.get_actions():
		if InputMap.action_get_events(action).size() != 0:
			keymaps[action] = InputMap.action_get_events(action)[0]
	load_keymap()

func get_movement_vector_normalized() -> Vector3:
	var input_vector: Vector3 = Vector3.ZERO
	
	if Input.is_action_pressed("Up"):
		input_vector.z -= 1
	if Input.is_action_pressed("Down"):
		input_vector.z += 1
	if Input.is_action_pressed("Left"):
		input_vector.x -= 1
	if Input.is_action_pressed("Right"):
		input_vector.x += 1
	
	input_vector = input_vector.normalized()
	
	return input_vector

func _input(_event):
	if Input.is_action_just_pressed("Interact"):
		#emit_signal("interact_pressed")  # Emit the signal when the interact action is pressed
		interact_pressed.emit()

	if Input.is_action_just_pressed("InteractAlternate"):
		interact_alternate_pressed.emit()

	if Input.is_action_just_pressed("Pause"):
		on_pause_action.emit()

func load_keymap() -> void:
	if not FileAccess.file_exists(keymaps_path):
		save_keymap() # There is no save file yet, so let's create one.
		return
	var file = FileAccess.open(keymaps_path, FileAccess.READ)
	var temp_keymap = file.get_var(true) as Dictionary
	file.close()
	# We don't just replace the keymaps dictionary, because if you
	# updated your game and removed/added keymaps, the data of this
	# save file may have invalid actions. So we check one by one to
	# make sure that the keymap dictionary really has all current actions.
	for action in keymaps.keys():
		if temp_keymap.has(action):
			keymaps[action] = temp_keymap[action]
			# Whilst setting the keymap dictionary, we also set the
			# correct InputMap event
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, keymaps[action])

func save_keymap() -> void:
	# For saving the keymap, we just save the entire dictionary as a var.
	var file := FileAccess.open(keymaps_path, FileAccess.WRITE)
	file.store_var(keymaps, true)
	file.close()
