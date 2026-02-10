extends TextureProgressBar

@export var has_progress_game_object: Node

func _ready():
	self.value = 0
	hide()

func _on_cutting_counter_on_progress_changed(progress_normalized):
	_apply_progress(progress_normalized)

func _on_stove_counter_on_progress_changed(progress_normalized):
	_apply_progress(progress_normalized)

func _on_progress_handler_on_progress_changed(progress_normalized):
	_apply_progress(progress_normalized)

func _apply_progress(progress_normalized) -> void:
	if progress_normalized == float(0) or progress_normalized == float(1):
		hide()
	else:
		show()
	self.value = progress_normalized * 100


func _show():
	self.visible = true

func _hide():
	self.visible = false
