extends Control

@export var timer:TextureProgressBar

func _process(_delta):
	timer.value = KitchenManager.get_game_playing_timer_normalized() * 100
