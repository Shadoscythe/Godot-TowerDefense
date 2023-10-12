extends Control

@onready var enemies_killed_label = $MarginContainer/Background/MarginContainer/MarginContainer/Background/MarginContainer/VBoxContainer/EnemiesKilledLable
@onready var waves_remaining_label = $MarginContainer/Background/MarginContainer/MarginContainer/Background/MarginContainer/VBoxContainer/CurrentWaveLabel
@onready var game_scene = $/root/SceneHandler/GameScene

func _ready():
	$MarginContainer/Background/MarginContainer/Buttons/RetryButton.pressed.connect(get_node("/root/SceneHandler").on_retry_button_pressed)
	$MarginContainer/Background/MarginContainer/Buttons/ExitButton.pressed.connect(get_node("/root/SceneHandler").on_quit_pressed)
	enemies_killed_label.set_text("Enemies Killed: " + str(game_scene.enemies_killed))
	waves_remaining_label.set_text("Current Wave: " + str(game_scene.current_wave) + "/" + str(game_scene.max_wave))
