extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	%KitchenManager.OnStateChanged.connect(_kitchen_manager_on_state_changed)
	show()

func _kitchen_manager_on_state_changed():
	if %KitchenManager.IsCountdownToStartActive():
		hide()
