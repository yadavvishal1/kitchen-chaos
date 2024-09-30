extends Node3D

@export var move_speed: float = 6
@export var rot_speed: float = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input_vector: Vector3 = Vector3(0, 0, 0)
	var forward: Vector3 = transform.basis.z
	
	if Input.is_action_pressed("Up"):
		input_vector.z = -1
	if Input.is_action_pressed("Down"):
		input_vector.z = +1
	if Input.is_action_pressed("Left"):
		input_vector.x = -1
	if Input.is_action_pressed("Right"):
		input_vector.x = +1
	
	input_vector = input_vector.normalized()
	
	var move_dir:Vector3 = Vector3(input_vector.x, 0, input_vector.z)
	transform.origin += Vector3(move_dir) * move_speed * delta
	rotation.y = lerp_angle(rotation.y, atan2(move_dir.x, move_dir.z), delta * rot_speed)

	

	
	
	
	
	
	
