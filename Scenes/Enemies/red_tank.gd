extends PathFollow2D

var enemy_type = "RedTank"
var speed = GameData.enemy_data[enemy_type]["speed"]
var hp = GameData.enemy_data[enemy_type]["hp"]
var damage = GameData.enemy_data[enemy_type]["damage"]
var reward = GameData.enemy_data[enemy_type]["reward"]
var health_bar_size = Vector2(hp / 3 + 20, 4)
var dead = false

var destroy_animation = preload("res://Scenes/SupportScenes/destroy_hit_effect.tscn")
@onready var game_scene = $/root/SceneHandler/GameScene
@onready var health_bar = $HealthBar
@onready var impact_area = $Impact
var HitScanImpact = preload("res://Scenes/SupportScenes/HitScanImpact.tscn")


func _ready():
	health_bar.max_value = hp
	health_bar.value = hp
	health_bar.set_scale(health_bar_size)
	health_bar.set_as_top_level(true)
	health_bar.set_position(position  - Vector2(0,30))
	health_bar.set_visible(true)

func _physics_process(delta):
	if get_progress_ratio() == 1.0:
		game_scene.on_base_damage(damage)
		queue_free()
	if not dead:
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
	hit_scan_impact() #Change impact types later between projectiles and hitscans
	hp -= damage
	health_bar.value = hp
	if hp <= 0:
		on_destroy()
		
func on_destroy():
	dead = true
	$TankSprite.modulate = Color("6e6e6e")
	add_child(destroy_animation.instantiate())
	health_bar.set_visible(false)
	game_scene.reward(reward)
	$CharacterBody2D.queue_free()
	await get_tree().create_timer(.3).timeout #wait for animation
	self.queue_free()
	game_scene.enemies_killed += 1
	
	
