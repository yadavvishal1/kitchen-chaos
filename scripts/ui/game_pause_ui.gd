extends Control

@export var main_menu_button: Button
@export var resume_button: Button
@export var options_ui: Control
@onready var kitchen_manager = %KitchenManager

func _ready():
	kitchen_manager.OnGamePaused.connect(kitchen_manager_on_game_paused)
	kitchen_manager.OnGameUnpaused.connect(kitchen_manager_on_game_unpaused)
	hide()
	options_ui.hide()

func kitchen_manager_on_game_paused():
	show()

func kitchen_manager_on_game_unpaused():
	hide()


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/main_menu_ui.tscn")

func _on_resume_button_pressed():
	kitchen_manager.toggle_pause_game()

func _on_options_button_pressed():
	options_ui.show()
