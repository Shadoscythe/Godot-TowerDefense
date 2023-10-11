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

func fire_hit_scan():
	var animation_number = str(fire_barrel)
	AnimPlayer.play("Fire" + animation_number)
	fire_barrel += 1
	if fire_barrel > barrel_count:
		fire_barrel = 1	

func fire_projectile():
	pass
	
func select_enemy():
	var enemy_priority_array = [] #used to select the target that is hightest priority (furthest along path by default)
	
	for i in enemy_array:
		var enemy_name = i.name.rstrip("0123456789")  #removes all numbers after enemy name 
		var enemy_type = GameData.enemy_data[enemy_name]["type"]	#checks to see if enemy is a crate or a tank
		var enemy_priority #used so crates can be set to 0
		if enemy_type != "crate":
			enemy_priority = i.progress #if enemy isnt a crate set priority to however far along the path they are
		else:
			enemy_priority = 0 #if enemy is crate set priority to 0
		enemy_priority_array.append(enemy_priority) #add priority value to array
	var max_offset = enemy_priority_array.max() #finds highest value in enemy priority array
	var target_index = enemy_priority_array.find(max_offset) #finds highest priority enemy
	target = enemy_array[target_index] #sets target

func _on_Range_body_entered(body):
	enemy_array.append(body.get_parent())

func _on_Range_body_exited(body):
	enemy_array.erase(body.get_parent())

