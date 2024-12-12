extends Control

@export var countdown_text:Label

func _ready():
	KitchenManager.OnStateChanged.connect(_on_state_changed)
	visible = false

func _on_state_changed():
	if KitchenManager.IsCountdownToStartActive():
		show()
	else:
		hide()

func _show() -> void:
	visible = true

func _hide() -> void:
	visible = false

func _process(_delta) -> void:
	countdown_text.text = str(ceil(KitchenManager.get_countdown_to_start_timer()))
