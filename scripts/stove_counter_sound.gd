extends AudioStreamPlayer3D

@export var stove_counter:StoveCounter

func _on_stove_counter_on_state_changed(state):
	var play_sound: bool = state == stove_counter.State.Frying or state == stove_counter.State.Fried
	if play_sound:
		playing = true
	else:
		playing = false
