extends Control


@export var play_button: Button
@export var quit_button: Button
@onready var timer: Timer = Timer.new()

func _ready():
	Engine.time_scale = 1.0

func _on_quit_button_pressed():
	get_tree().quit() 

func _on_play_button_pressed():
	Loader.load_scene(Loader.Scene.LOADING_SCENE)
