extends Control

@export var timer:TextureProgressBar
@onready var kitchen_manager = %KitchenManager

func _process(_delta):
	timer.value = kitchen_manager.get_game_playing_timer_normalized() * 100
