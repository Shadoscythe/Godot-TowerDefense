extends CanvasLayer

@onready var health_bar = $HUD/InfoBar/InfoBarMarginContainer/InfoBarHbox/HealthInfo/HealthBar
@onready var health_counter = $HUD/InfoBar/InfoBarMarginContainer/InfoBarHbox/HealthInfo/HealthBar/HealthCounter
@onready var money_counter = $HUD/InfoBar/InfoBarMarginContainer/InfoBarHbox/DollarContainer/DollarCount
@onready var wave_counter = $HUD/InfoBar/InfoBarMarginContainer/InfoBarHbox/RemainingWaves/WaveCount
@onready var game_scene = $/root/SceneHandler/GameScene

func _ready():
	connect_build_buttons()
	await get_tree().create_timer(.1).timeout #waiting for game_scene to load
	update_wave_counter()
func connect_build_buttons(): #Connect build buttons to their proper towers
	for i in get_tree().get_nodes_in_group("build_buttons"):
		i.pressed.connect(get_parent().initiate_build_mode.bind(i.name))

func update_wave_counter():
	wave_counter.set_text(str(game_scene.current_wave) + " / " + str(game_scene.max_wave))

func update_health_bar(health):
	var tween = create_tween() #creates a tween for smooooooth health bar
	tween.tween_property(health_bar, "value", health, 0.1) #interpolate the health value on the health bar
	health_counter.set_text(str(game_scene.base_health) + " / 100")
	if health > 60:
		health_bar.set_tint_progress("6d8600") #green
	elif health <= 60 and health >= 30:
		health_bar.set_tint_progress("b46810") #orange
	else:
		health_bar.set_tint_progress("ab1400") #red
	

func update_money_counter(value):
	money_counter.set_text(str(value)) #set money counter value
