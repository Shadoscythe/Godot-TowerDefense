extends PathFollow2D

var tank_type = "SandTank"
var speed = GameData.tank_data[tank_type]["speed"]
var hp = GameData.tank_data[tank_type]["hp"]
var health_bar_size = Vector2(hp / 3 + 20, 4)

@onready var health_bar = $HealthBar
@onready var impact_area = $Impact
var HitScanImpact = preload("res://Scenes/SupportScenes/HitScanImpact.tscn")

func _ready():
	health_bar.max_value = hp
	health_bar.value = hp
	health_bar.set_scale(health_bar_size)
	health_bar.set_as_top_level(true)
	

func _physics_process(delta):
	move(delta)
	

func move(delta):
	set_progress(get_progress() + speed * delta)
	health_bar.set_position(position - Vector2(0,30))
	
func hit_scan_impact():
	randomize()
	var x_pos = randi() % 31
	randomize()
	var y_pos = randi() % 31
	var impact_location = Vector2(x_pos, y_pos)
	var new_impact = HitScanImpact.instantiate()
	new_impact.position = impact_location
	impact_area.add_child(new_impact)

func on_hit(damage):
	hit_scan_impact()  #Change impact types later between projectiles and hitscans
	hp -= damage
	health_bar.value = hp
	if hp <= 0:
		on_destroy()
		
func on_destroy():
	$CharacterBody2D.queue_free()
	await get_tree().create_timer(.2).timeout
	self.queue_free()
