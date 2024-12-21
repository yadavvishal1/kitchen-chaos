extends AudioStreamPlayer3D

@export var stove_counter:StoveCounter
var warning_sound_timer: float
var play_warning_sound: bool

func _on_stove_counter_on_state_changed(state):
	var play_sound: bool = state == stove_counter.State.Frying or state == stove_counter.State.Fried
	if play_sound:
		playing = true
	else:
		playing = false

func _on_stove_counter_onprogress_changed(progress_normalized):
	var burn_show_progress_amount: float = 0.5
	play_warning_sound = stove_counter.is_fried() and progress_normalized >= burn_show_progress_amount

func _process(delta):
	if play_warning_sound:
		warning_sound_timer -= delta
		if warning_sound_timer <= 0.0:
			var warning_sound_timer_max = 0.2
			warning_sound_timer = warning_sound_timer_max
			stove_counter.sound_manager.play_warning_sound(stove_counter.position)
