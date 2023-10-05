extends Control

func _ready():
	var SceneHandler = get_parent()
	var BackButton = get_node("Background/MarginContainer/VBoxContainer/Back")
	BackButton.pressed.connect(SceneHandler.on_back_button_pressed)
