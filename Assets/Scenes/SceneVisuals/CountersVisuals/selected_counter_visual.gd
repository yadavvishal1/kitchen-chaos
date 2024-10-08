extends Node3D

@onready var selected_visual_change = $"Selected"  # Reference the 'Selected' node within the scene

func _ready() -> void:
	get_tree().connect("node_added", Callable(self, "_on_node_added"))

func _on_node_added(node: Node) -> void:
	# Check if the added node is the player instance
	if node.name == "Player":  # Replace "Player" with the actual name of your player node
		node.connect("selected", Callable(self, "_selected_visual_changed"))

func _selected_visual_changed(visible: bool) -> void:
	selected_visual_change.visible = visible
