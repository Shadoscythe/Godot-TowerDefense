extends Node2D

var enemy_array = []
var built = false
var target
var ready_to_fire = true
var tower_type
var barrel_count
var category
var fire_barrel = 1
@onready var AnimPlayer = $AnimationPlayer


func _physics_process(delta):
	if enemy_array.size() != 0 and built:
		select_enemy()	
		aim()
		if ready_to_fire:
			fire()
	else:
		target = null
func aim():
	get_node("Turret").look_at(target.position)

func fire():
	ready_to_fire = false
	if category == "HitScan":
		if barrel_count > 1:
			fire_hit_scan()
		else:
			fire_hit_scan()
	elif category == "HitScanMultiBarrel":
		fire_hit_scan()
	elif category == "Projectile":
		fire_projectile()
	target.on_hit(GameData.tower_data[tower_type]["damage"])
	await get_tree().create_timer(GameData.tower_data[tower_type]["rof"]).timeout
	ready_to_fire = true
	print("fire")
	
func fire_hit_scan():
	var animation_number = str(fire_barrel)
	AnimPlayer.play("Fire" + animation_number)
	fire_barrel += 1
	if fire_barrel > barrel_count:
		fire_barrel = 1	
	
func fire_projectile():
	pass
	
func select_enemy():
	var enemy_progress_array = []
	for i in enemy_array:
		enemy_progress_array.append(i.progress)
	var max_offset = enemy_progress_array.max()
	var enemy_index = enemy_progress_array.find(max_offset)
	target = enemy_array[enemy_index]
	
func _on_Range_body_entered(body):
	enemy_array.append(body.get_parent())

func _on_Range_body_exited(body):
	enemy_array.erase(body.get_parent())

