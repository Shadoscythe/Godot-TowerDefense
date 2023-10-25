extends Control

var SceneHandler = get_parent()

func _ready():
	connect_level_select_buttons()


func connect_level_select_buttons(): #Connect build buttons to their proper towers
	for i in get_tree().get_nodes_in_group("LevelSelectButtons"):
		i.pressed.connect(get_parent().load_level.bind(i.name))
