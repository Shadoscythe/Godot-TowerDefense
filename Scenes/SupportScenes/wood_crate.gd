extends Node2D

var dead = false
var first_hit = false
var enemy_type = "WoodCrate"
var hp = GameData.enemy_data[enemy_type]["hp"]
var reward = GameData.enemy_data[enemy_type]["reward"]
var health_bar_size = Vector2(hp / 3 + 20, 4)
@onready var health_bar = $HealthBar
@onready var impact_area = $Impact
@onready var game_scene = $/root/SceneHandler/GameScene
var HitScanImpact = preload("res://Scenes/SupportScenes/HitScanImpact.tscn")

func _ready():
	await get_tree().create_timer(.1).timeout #Use later to wait for airdrop animation to finish
	var tile_position = game_scene.map.get_node("TowerExclusion").local_to_map(self.position)
	game_scene.add_to_exclusion(tile_position)

#
#	Enemy functions
#

func on_first_hit():
	health_bar.max_value = hp
	health_bar.value = hp
	health_bar.set_scale(health_bar_size)
	health_bar.set_as_top_level(true)
	health_bar.set_position(position  - Vector2(0,30))
	health_bar.set_visible(true)
func on_hit(damage):
	if not first_hit:
		first_hit = true
		on_first_hit()
	hit_scan_impact()  #Change impact types later between projectiles and hitscans
	hp -= damage
	health_bar.value = hp
	if hp <= 0:
		on_destroy()

func hit_scan_impact():
	randomize()
	var x_pos = randi() % 25
	randomize()
	var y_pos = randi() % 25
	var impact_location = Vector2(x_pos, y_pos)
	var new_impact = HitScanImpact.instantiate()
	new_impact.position = impact_location
	impact_area.add_child(new_impact)

func on_destroy():
	dead = true
	health_bar.set_visible(false)
	game_scene.reward(reward)
	$CharacterBody2D.queue_free()
	await get_tree().create_timer(.2).timeout
	self.queue_free()
