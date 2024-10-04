extends Node


func get_movement_vector_normalized():
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
