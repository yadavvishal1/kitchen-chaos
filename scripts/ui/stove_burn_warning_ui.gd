extends Sprite3D

@export var stove_counter: StoveCounter

func _ready():
	hide()

func _on_stove_counter_on_progress_changed(progress_normalized):
	var burn_show_progress_amount: float = 0.5
	var _show: bool = stove_counter.is_fried() and progress_normalized >= burn_show_progress_amount
	if _show:
		show()
	else:
		hide()
