extends Control

@export var countdown_text:Label
@onready var animator: AnimationPlayer = $AnimationPlayer
@export var sound_manager: SoundManager 
@onready var kitchen_manager = %KitchenManager
const NUMBER_POPUP: String = "number_popup"
var previous_countdown_number:int

func _ready():
	kitchen_manager.OnStateChanged.connect(_on_state_changed)
	hide()

func _on_state_changed():
	if kitchen_manager.IsCountdownToStartActive():
		show()
	else:
		hide()

func _process(_delta) -> void:
	var countdown_number = ceili(kitchen_manager.get_countdown_to_start_timer())
	countdown_text.text = str(countdown_number)
	if previous_countdown_number != countdown_number:
		previous_countdown_number = countdown_number
		animator.play(NUMBER_POPUP)
		sound_manager.play_countdown_sound()
