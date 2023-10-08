extends Control

func _ready():
	$MarginContainer/Background/MarginContainer/Buttons/RetryButton.pressed.connect(get_node("/root/SceneHandler").on_retry_button_pressed)
	$MarginContainer/Background/MarginContainer/Buttons/ExitButton.pressed.connect(get_node("/root/SceneHandler").on_quit_pressed)
