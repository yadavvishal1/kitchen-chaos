extends Node

signal state_changed
signal game_paused
signal game_unpaused

enum State{
	WAITING_TO_START,
	COUNTDOWN_TO_START,
	GAME_PLAYING,
	GAME_OVER
}

@onready var state: State = State.WAITING_TO_START

var waiting_to_start_timer: float = 1.0
var countdown_to_start_timer: float = 3
var game_playing_timer: float
var game_playing_timer_max: float = 300.0
var can_start_game: bool = false  # Flag to control when to start the game
var is_game_paused: bool = false

func _ready():
	GameInput.pause_pressed.connect(_game_input_pause_pressed)
	GameInput.interact_pressed.connect(_game_input_interact_pressed)

func _process(delta):
	match  state:
		State.COUNTDOWN_TO_START:
			countdown_to_start_timer -= delta
			if countdown_to_start_timer <= 0.0:
				state = State.GAME_PLAYING
				game_playing_timer = game_playing_timer_max
				state_changed.emit()

		State.GAME_PLAYING:
			game_playing_timer -= delta
			if game_playing_timer <= 0.0:
				state = State.GAME_OVER
				state_changed.emit()

		State.GAME_OVER:
			pass

func is_game_playing() -> bool:
	return state == State.GAME_PLAYING

func is_countdown_to_start_active() -> bool:
	return state == State.COUNTDOWN_TO_START

func get_countdown_to_start_timer() -> float:
	return countdown_to_start_timer

func is_game_over() -> bool:
	return state == State.GAME_OVER

func get_game_playing_timer_normalized() -> float:
	return 1- (game_playing_timer / game_playing_timer_max) 

func toggle_pause_game() -> void:
	is_game_paused = !is_game_paused
	if is_game_paused:
		Engine.time_scale = 0.0
		game_paused.emit()
	else:
		Engine.time_scale = 1.0
		game_unpaused.emit()

func _game_input_pause_pressed() -> void:
	toggle_pause_game()

func _game_input_interact_pressed() -> void:
	if state == State.WAITING_TO_START:
		state = State.COUNTDOWN_TO_START
		state_changed.emit()
