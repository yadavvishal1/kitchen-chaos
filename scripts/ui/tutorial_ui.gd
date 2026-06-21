extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	%KitchenManager.state_changed.connect(_kitchen_manager_on_state_changed)
	show()

func _kitchen_manager_on_state_changed():
	if %KitchenManager.is_countdown_to_start_active():
		hide()

func _on_move_up_button_remapped(_text: String) -> void:
	pass
