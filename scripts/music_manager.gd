extends AudioStreamPlayer2D

var config = ConfigFile.new()
var volume: float = 0.3

func _ready():
	load_volume()

func change_volume() -> void:
	
	volume += 0.1
	if volume > 1.0:
		volume = 0.0 
	volume_db = linear_to_db(volume)

		# Save the new volume to the config
	config.set_value("audio", "music_volume", volume)
	var save_err = config.save("user://settings.cfg")
	if save_err != OK:
			print("Error saving config file.")

func get_volume() -> float:
	return volume

# Method to load the saved volume from the config file
func load_volume() -> void:
	var err = config.load("user://settings.cfg")
	if err != OK:
		volume = 0.3
	else:
		volume = config.get_value("audio", "music_volume", volume)

	volume_db = linear_to_db(volume)
