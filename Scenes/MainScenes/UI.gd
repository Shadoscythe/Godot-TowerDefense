extends CanvasLayer

func _ready():
	connect_build_buttons()

func connect_build_buttons(): #Connect build buttons to their proper towers
	for i in get_tree().get_nodes_in_group("build_buttons"):
		i.pressed.connect(get_parent().initiate_build_mode.bind(i.name))
