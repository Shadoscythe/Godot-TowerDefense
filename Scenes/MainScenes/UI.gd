extends CanvasLayer

@onready var health_bar = $HUD/InfoBar/InfoBarMarginContainer/InfoBarHbox/HealthInfo/HealthBar
@onready var money_counter = $HUD/InfoBar/InfoBarMarginContainer/InfoBarHbox/DollarContainer/DollarCount

func _ready():
	connect_build_buttons()

func connect_build_buttons(): #Connect build buttons to their proper towers
	for i in get_tree().get_nodes_in_group("build_buttons"):
		i.pressed.connect(get_parent().initiate_build_mode.bind(i.name))

func update_health_bar(health):

	var tween = create_tween() #creates a tween for smooooooth health bar
	tween.tween_property(health_bar, "value", health, 0.1) #interpolate the health value on the health bar
	if health > 60:
		health_bar.set_tint_progress("6d8600") #green
	elif health <= 60 and health >= 30:
		health_bar.set_tint_progress("b46810") #orange
	else:
		health_bar.set_tint_progress("ab1400") #red
	

func update_money_counter(value):
	money_counter.set_text(str(value)) #set money counter value
