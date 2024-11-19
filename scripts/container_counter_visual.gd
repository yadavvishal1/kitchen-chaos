extends Node3D

@onready var kitchen_object_parent:KitchenObjectParent
@onready var animation_tree: AnimationTree = $AnimationTree

func _on_container_counter_player_grabbed_object():
	if kitchen_object_parent == null:
		animation_tree["parameters/conditions/open_close"] = true


func _on_animation_tree_animation_finished(anim_name):
	kitchen_object_parent = null
	animation_tree["parameters/conditions/open_close"] = false
	
