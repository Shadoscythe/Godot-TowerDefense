extends Control

func _ready():
	print("main menu")
	var SceneHandler = get_parent()
	var NewGameButton = get_node("MarginContainer/VBoxContainer/NewGame")
	var QuitButton = get_node("MarginContainer/VBoxContainer/Quit")
	var SettingsButton = get_node("MarginContainer/VBoxContainer/Settings")
	var AboutButton = get_node("MarginContainer/VBoxContainer/About")
	
	NewGameButton.pressed.connect(SceneHandler.on_new_game_pressed)
	QuitButton.pressed.connect(SceneHandler.on_quit_pressed)
	SettingsButton.pressed.connect(SceneHandler.on_settings_pressed)
	AboutButton.pressed.connect(SceneHandler.on_about_pressed)
