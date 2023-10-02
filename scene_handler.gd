extends Node

@onready var game_scene = $MainMenu
var previous_scene
var BackButton
var NewGameButton 
var QuitButton
var SettingsButton
var AboutButton

func _ready():
	connect_buttons()
	
func load_main_menu():
	game_scene = load("res://Scenes/UIScenes/MainMenu.tscn").instantiate()
	add_child(game_scene)
	connect_buttons()
func connect_buttons():
	NewGameButton = get_node("MainMenu/MarginContainer/VBoxContainer/NewGame")
	QuitButton = get_node("MainMenu/MarginContainer/VBoxContainer/Quit")
	SettingsButton = get_node("MainMenu/MarginContainer/VBoxContainer/Settings")
	AboutButton = get_node("MainMenu/MarginContainer/VBoxContainer/About")
	
	NewGameButton.pressed.connect(on_new_game_pressed)
	QuitButton.pressed.connect(on_quit_pressed)
	SettingsButton.pressed.connect(on_settings_pressed)
	AboutButton.pressed.connect(on_about_pressed)

func on_new_game_pressed():
	get_node("MainMenu").queue_free()
	previous_scene = game_scene
	game_scene = load("res://Scenes/MainScenes/GameScene.tscn").instantiate()
	add_child(game_scene)
	
func on_quit_pressed():
	get_tree().quit()
	
func on_settings_pressed():
	pass

func on_about_pressed():
	previous_scene = game_scene
	game_scene = load("res://Scenes/UIScenes/CreditsScreen.tscn").instantiate()
	$MainMenu.queue_free()
	add_child(game_scene)
	BackButton = get_node("CreditsScreen/Background/MarginContainer/VBoxContainer/Back")
	BackButton.pressed.connect(on_back_button_pressed)
	$CreditsScreen.set_name("CurrentScene")

func on_back_button_pressed():
	get_node("CurrentScene").queue_free()
	previous_scene = game_scene
	load_main_menu()
	
	
#	game_scene = previous_scene
#	game_scene.instantiate()
#	print(game_scene)
#	$CreditsScreen.free()
#	add_child(game_scene)
#	previous_scene = null


