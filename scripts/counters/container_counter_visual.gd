extends Node3D

@onready var kitchen_object_parent:KitchenObjectParent
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_container_counter_player_grabbed_object():
	if kitchen_object_parent == null:
		animation_player.play("container_counter_open_close")
