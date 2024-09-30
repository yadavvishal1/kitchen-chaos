extends Node3D

@onready var animation_tree : AnimationTree = $AnimationTree
@export var player: Node3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_animation_parameters()

func update_animation_parameters():
	var is_walking = player.is_walking
	animation_tree["parameters/conditions/Idle"] = not is_walking
	animation_tree["parameters/conditions/IsWalking"] = is_walking
