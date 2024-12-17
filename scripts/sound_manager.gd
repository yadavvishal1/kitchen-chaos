class_name SoundManager extends Node

@export var audio_clip_ref_res: AudioClipRefRes
@onready var delivery_manager: DeliveryManager = %DeliveryManager

var config = ConfigFile.new()
var _volume: float = 1.0
var audio_player: AudioStreamPlayer3D
@onready var delivery_counter_position = %DeliveryCounter.global_position

func _ready() -> void:
	audio_player = AudioStreamPlayer3D.new() # Initialize the audio player
	add_child(audio_player)
	load_volume()
	var cutting_counters = get_tree().get_nodes_in_group("cutting_counters")
	for counter in cutting_counters:
		if counter is CuttingCounter:
			counter.OnAnyCut.connect(_on_any_cut)
	var counters = get_tree().get_nodes_in_group("counters")
	for counter:BaseCounter in counters:
		if counter.has_signal("OnAnyObjectPlacedHere"):
			counter.OnAnyObjectPlacedHere.connect(_on_any_object_placed_here)
	
	audio_player = AudioStreamPlayer3D.new()
	add_child(audio_player)

func _play_sound(audio_clip: AudioStream, position: Vector3, volume_multiplier: float = 1.0) -> void:
	# Set the position and play the sound at that position
	audio_player.stream = audio_clip
	audio_player.volume_db = linear_to_db(volume_multiplier * _volume) 
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

func _on_player_on_picked_something(pos):
	play_sound(audio_clip_ref_res.object_pickup, pos)

func _on_any_object_placed_here(pos):
	play_sound(audio_clip_ref_res.object_drop, pos)


func _on_trash_counter_on_any_object_trashed(pos):
		play_sound(audio_clip_ref_res.trash, pos)

func play_foot_step_sound(pos: Vector3, volume: float):
	play_sound(audio_clip_ref_res.footstep, pos, volume)

func change_volume() -> void:
	_volume += 0.1
	if _volume > 1.0:
		_volume = 0.0 

		# Save the new volume to the config
	config.set_value("audio", "sound_effects_volume", _volume)
	var save_err = config.save("user://settings.cfg")
	if save_err != OK:
		print("Error saving config file.")

func get_volume() -> float:
	return _volume

# Method to load the saved volume from the config file
func load_volume() -> void:
	var err = config.load("user://settings.cfg")
	if err != OK:
		_volume = 1.0
	else:
		_volume = config.get_value("audio", "sound_effects_volume", 1.0)
	audio_player.volume_db = linear_to_db(_volume)
