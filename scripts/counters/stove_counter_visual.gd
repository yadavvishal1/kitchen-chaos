class_name StoveCounterVisual extends Node

@export var stove_on_visual: Node3D
@export var sizzling_particles: GPUParticles3D


func _on_stove_counter_on_state_changed(state):
	var show_visual: bool = state == StoveCounter.State.Frying or state == StoveCounter.State.Fried
	stove_on_visual.visible = show_visual
	sizzling_particles.visible = show_visual
