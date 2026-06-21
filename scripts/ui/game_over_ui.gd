extends Control

@onready var delivery_manager: DeliveryManager = %DeliveryManager

@export var recipes_deivered_text: Label

func _ready():
	%KitchenManager.state_changed.connect(_on_state_changed)
	visible = false

func _on_state_changed():
	if %KitchenManager.is_game_over():
		show()
		recipes_deivered_text.text = str(delivery_manager.get_successful_recipes_amount())

	else:
		hide()

func _show() -> void:
	visible = true

func _hide() -> void:
	visible = false
