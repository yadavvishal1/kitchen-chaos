extends Control

@export var sound_effect_button: Button
@export var music_button: Button
@export var close_button: Button
@export var sound_manager: SoundManager
@export var music_manager: AudioStreamPlayer2D

func _ready():
	%KitchenManager.OnGameUnpaused.connect(_kitchen_manager_on_game_unpaused)
	await get_tree().node_added
	music_manager.load_volume()
	sound_manager.load_volume()
	update_visulas()
	hide()

func update_visulas() -> void:
	sound_effect_button.text = "Sound Effect: " + str(sound_manager.get_volume() * 10.0)
	music_button.text = "Music: " + str(music_manager.get_volume() * 10.0)

func _on_sound_effects_button_pressed():
	sound_manager.change_volume()
	update_visulas()

func _on_music_button_pressed():
	music_manager.change_volume()
	update_visulas()

func _on_close_button_pressed():
	hide()

func _kitchen_manager_on_game_unpaused():
	hide()
