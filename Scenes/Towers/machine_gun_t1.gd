extends "res://Scenes/Towers/turret_control.gd"

var range = GameData.tower_data["MachineGunT1"]["range"] / 2


func _ready():
	set_range(range)
	
func set_range(range):
	$Range/Circle.shape.set_radius(range)
