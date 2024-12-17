extends Node

signal OnStateChanged
signal OnGamePaused
signal OnGameUnpaused

enum State{
	WaitingToStart,
	CountdownToStart,
	GamePlaying,
	GameOver
}

@onready var state: State = State.WaitingToStart

var waiting_to_start_timer: float = 1.0
var countdown_to_start_timer: float = 3
var game_playing_timer: float
var game_playing_timer_max: float = 30.0
var can_start_game: bool = false  # Flag to control when to start the game
var is_game_paused: bool = false

func _ready():
	GameInput.on_pause_action.connect(_game_input_on_pause_action)

func _process(delta):
	match  state:
		State.WaitingToStart:
			waiting_to_start_timer -= delta
			if waiting_to_start_timer <= 0.0:
				state = State.CountdownToStart
				OnStateChanged.emit()

		State.CountdownToStart:
			countdown_to_start_timer -= delta
			if countdown_to_start_timer <= 0.0:
				state = State.GamePlaying
				game_playing_timer = game_playing_timer_max
				OnStateChanged.emit()

		State.GamePlaying:
			game_playing_timer -= delta
			if game_playing_timer <= 0.0:
				state = State.GameOver
				OnStateChanged.emit()

		State.GameOver:
			pass

func IsgamePlaying() -> bool:
	return state == State.GamePlaying

func IsCountdownToStartActive() -> bool:
	return state == State.CountdownToStart

func get_countdown_to_start_timer() -> float:
	return countdown_to_start_timer

func IsGameOver() -> bool:
	return state == State.GameOver

func get_game_playing_timer_normalized() -> float:
	return 1- (game_playing_timer / game_playing_timer_max) 

func toggle_pause_game() -> void:
	is_game_paused = !is_game_paused
	if is_game_paused:
		Engine.time_scale = 0.0
		OnGamePaused.emit()
	else:
		Engine.time_scale = 1.0
		OnGameUnpaused.emit()

func _game_input_on_pause_action() -> void:
	toggle_pause_game()
