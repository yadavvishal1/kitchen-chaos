class_name SoundManager extends Node

@export var audio_clip_ref_res: AudioClipRefRes
@onready var delivery_manager: DeliveryManager = %DeliveryManager

var audio_player: AudioStreamPlayer3D
@onready var delivery_counter_position = %DeliveryCounter.global_position

func _ready() -> void:
	var cutting_counters = get_tree().get_nodes_in_group("cutting_counters")
	for counter in cutting_counters:
		if counter is CuttingCounter:
			counter.OnAnyCut.connect(_on_any_cut)
	audio_player = AudioStreamPlayer3D.new()
	add_child(audio_player)

func _play_sound(audio_clip: AudioStream, position: Vector3, volume: float = 1.0) -> void:
	# Set the position and play the sound at that position
	audio_player.stream = audio_clip
	audio_player.volume_db = volume
	audio_player.global_position = position
	audio_player.play()

func play_sound(audio_clip_array: Array[AudioStream], position: Vector3, volume: float = 1.0) -> void:
	_play_sound(audio_clip_array.pick_random(), position, volume)

func _on_delivery_manager_on_recipe_success():
	play_sound(audio_clip_ref_res.delivery_success, delivery_counter_position)

func _on_delivery_manager_on_recipe_failed():
	play_sound(audio_clip_ref_res.delivery_fail, delivery_counter_position)

func _on_any_cut(pos: Vector3):
	play_sound(audio_clip_ref_res.chop, pos)
