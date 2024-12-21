extends Control

@export var countdown_text:Label
@onready var animator: AnimationPlayer = $AnimationPlayer
@export var sound_manager: SoundManager 
const NUMBER_POPUP: String = "number_popup"
var previous_countdown_number:int

func _ready():
	%KitchenManager.OnStateChanged.connect(_on_state_changed)
	hide()

func _on_state_changed():
	if %KitchenManager.IsCountdownToStartActive():
		show()
	else:
		hide()

func _process(_delta) -> void:
	var countdown_number = ceili(%KitchenManager.get_countdown_to_start_timer())
	countdown_text.text = str(countdown_number)
	if previous_countdown_number != countdown_number:
		previous_countdown_number = countdown_number
		animator.play(NUMBER_POPUP)
		sound_manager.play_countdown_sound()
