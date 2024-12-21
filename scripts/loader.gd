extends Node

# Define an enum for the scenes
enum Scene {
	MAIN_MENU_SCENE,   
	GAME_SCENE,
	LOADING_SCENE
}

func load_scene(target_scene: Scene) -> void:
	match target_scene:
		Scene.MAIN_MENU_SCENE:
			get_tree().change_scene_to_file("res://scenes/ui/main_menu_ui.tscn")
		Scene.GAME_SCENE:
			get_tree().change_scene_to_file("res://scenes/game_scene.tscn")
		Scene.LOADING_SCENE:
			get_tree().change_scene_to_file("res://scenes/ui/loading_scene.tscn")
			await get_tree().create_timer(1).timeout
			load_scene(Scene.GAME_SCENE)
