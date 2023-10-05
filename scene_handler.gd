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

func on_back_button_pressed():
	load_ui_scene("MainMenu")

func load_ui_scene(scene):
	game_scene.queue_free()
	game_scene = load("res://Scenes/UIScenes/" + scene + ".tscn").instantiate()
	add_child(game_scene)

func load_game_scene(scene):
	game_scene.queue_free()
	game_scene = load("res://Scenes/MainScenes/" + scene + ".tscn").instantiate()
	add_child(game_scene)

	



