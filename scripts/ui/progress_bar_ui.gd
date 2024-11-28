extends TextureProgressBar

@export var has_progress_game_object: Node

func _ready():
	self.value = 0
	hide()

func _on_cutting_counter_onprogress_changed(progress_normalized):
	self.value = progress_normalized * 100

func _on_stove_counter_onprogress_changed(progress_normalized):
	self.value = progress_normalized * 100

	if progress_normalized == float(0) or progress_normalized == float(1):
		hide()
	else:
		show()

func _show():
	self.visible = true

func _hide():
	self.visible = false
