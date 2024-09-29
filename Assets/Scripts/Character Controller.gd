extends Node3D

@export var move_speed: float = 6
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var inputvector: Vector3 = Vector3(0, 0, 0)
	
	if Input.is_action_pressed("Up"):
		inputvector.z = -1;
	if Input.is_action_pressed("Down"):
		inputvector.z = +1;
	if Input.is_action_pressed("Left"):
		inputvector.x = -1
	if Input.is_action_pressed("Right"):
		inputvector.x = +1
	
	inputvector = inputvector.normalized()
	
	transform.origin += Vector3(inputvector) * move_speed * delta
	
	
	
