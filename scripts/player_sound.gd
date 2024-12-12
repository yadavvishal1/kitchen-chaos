extends AudioStreamPlayer3D

@export var player:Player
@export var audio_clip_ref_res:AudioClipRefRes

var foot_step_timer:float
var foot_step_timer_max:float = 0.1


func _process(delta):
	foot_step_timer -= delta
	if foot_step_timer <= 0:
		foot_step_timer = foot_step_timer_max
		if player.is_walking:
			stream = audio_clip_ref_res.footstep.pick_random()
			playing = true
		else:
			playing = false
