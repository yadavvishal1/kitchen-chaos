extends Node3D

func _ready():
	var player = $"..".get_parent().get_node("Player")
	player.connect("selected_counter_changed", Callable(self, "on_selected_counter_changed"))
	visible = false

func on_selected_counter_changed():
	if !visible:
		visible = true
	else:
		visible = false
