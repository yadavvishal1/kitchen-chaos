extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_cutting_counter_on_cut():
	animation_player.play("cutting_counter_cut")

	await animation_player.animation_finished
	animation_player.play("RESET")
