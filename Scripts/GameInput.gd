extends Node

# Declare the signal
signal interact_pressed

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

func _input(event):
	if Input.is_action_just_pressed("Interact"):
		emit_signal("interact_pressed")  # Emit the signal when the interact action is pressed
