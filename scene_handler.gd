extends Node

@onready var game_scene = $MainMenu

func _ready():
	load_ui_scene("MainMenu")

func on_new_game_pressed():
	load_game_scene("GameScene") ###CHANGE LATER TO USE MAP SELECTION MENU###
	
func on_quit_pressed():
	get_tree().quit()
	
func on_settings_pressed():
	pass

func on_about_pressed():
	load_ui_scene("CreditsScreen")

func on_retry_button_pressed():
	load_ui_scene("MainMenu")
	get_tree().paused = false
	Engine.set_time_scale(1.0)

func on_back_button_pressed():
	var scene_to_load = GameData.scene_data[game_scene.name]["parentscene"]
	load_ui_scene(scene_to_load)

func load_ui_scene(scene):
	game_scene.queue_free()
	game_scene = load("res://Scenes/UIScenes/" + scene + ".tscn").instantiate()
	add_child(game_scene)

func load_game_scene(scene):
	game_scene.queue_free()
	game_scene = load("res://Scenes/MainScenes/" + scene + ".tscn").instantiate()
	add_child(game_scene)

	



