extends Node2D

# Map Data

@onready var map = $Map1 #what map are we using
@onready var exclusion_array = map.get_node("TowerExclusion").get_used_cells(0) #store occupied tiles in an array

# Build Data

var build_mode #is build mode currently happening
var build_type #what tower is being built
var build_valid #is current tile buildable?
var build_position #where a new tower is being built using global coordinates
var tile_position #what tile is the mouse hovering over using tilemap coordinates
var preview #control node for tower preview
signal tower_built

#Wave Data

var current_wave = 0 #what wave number is the current wave
var enemies_in_wave #how many enemies left in wave   =

#
# Process Functions
#

func _ready():
	pass
func _process(delta):
	if build_mode:
		update_tower_preview()
		
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel") and build_mode:
		cancel_build_mode()
		print('cancel')
	if event.is_action_pressed("ui_accept") and build_mode:
		verify_and_build()
		
#
# Building Functions
#

func initiate_build_mode(tower_type):
	if build_mode:
		cancel_build_mode()
	build_type = tower_type + "T1"
	set_tower_preview(build_type, get_global_mouse_position())
	build_mode = true
	print("yay")

func cancel_build_mode():
	get_node("UI/TowerPreview").free()
	build_mode = false

func verify_and_build():
	if build_valid: #and enough money #check if enough cash and if valid location
		var new_tower = load("res://Scenes/Towers/" + build_type + ".tscn").instantiate()
		new_tower.position = build_position
		new_tower.built = true
		new_tower.tower_type = build_type
		new_tower.category = GameData.tower_data[build_type]["category"]
		new_tower.barrel_count = GameData.tower_data[build_type]["barrelcount"]
		map.get_node("TowerContainer").add_child(new_tower, false)
		tower_built.emit()
		add_to_exclusion(tile_position)
		cancel_build_mode()
		#deduct money
		
func change_color(color):
	get_node("UI/TowerPreview/RangeIndicator").modulate = Color(color)
	get_node("UI/TowerPreview/DragTower").modulate = Color(color)

func set_tower_preview(tower_type, mouse_position):
	#Set Variables
	var drag_tower = load("res://Scenes/Towers/" + tower_type + ".tscn").instantiate() #Loads image for build preview
	drag_tower.set_name("DragTower") #Sets tower preview name
	
	#Range indicator circle
	var range_texture = Sprite2D.new() #Spawn a new node Sprite2D and call it range_texture
	var scaling = GameData.tower_data[tower_type]["range"] / 600.0 #Set the specific towers range to the circle size
	range_texture.scale = Vector2(scaling, scaling) #Scale circle to towers range
	var texture = load("res://Assets/UI/Art/range_overlay.png") #Load range art
	range_texture.texture = texture #Set range_textures texture to the range art
	range_texture.modulate = Color("ad54ff3d")
	range_texture.set_name("RangeIndicator") #Set readable name
	
	#Spawn Tower Preview node
	preview = Control.new() #spawn container for tower preview
	preview.add_child(drag_tower, true) #add tower preview as child to container
	preview.add_child(range_texture, true) #add range texture as child to container
	preview.set_name("TowerPreview") #set container name
	$UI.add_child(preview, true) #add container as child to UI

func update_tower_preview():
	var mouse_position = get_node("UI/HUD").get_global_mouse_position() #Sets mouse position
	tile_position = map.get_node("TowerExclusion").local_to_map(mouse_position) #Sets the current tile being hovered over
	build_position = map.get_node("TowerExclusion").map_to_local(tile_position)
	preview.position = build_position #Sets the preview position to the mouse position
	
	#Check to see if something is in moused tile
	if exclusion_array.has(tile_position) == true: #checks to see if obstacle is in tile
		if get_node("UI/TowerPreview/DragTower").modulate != Color("c60500c0"):
			change_color("c60500c0")
			build_valid = false
	else:
		if get_node("UI/TowerPreview/DragTower").modulate != Color("3d8e54a6"): 
			change_color("3d8e54a6")
			build_valid = true

func add_to_exclusion(tile):
	exclusion_array.append(tile)

#
# Wave Functions
#

func start_next_wave():
	var wave_data = retrieve_wave_data()
	await get_tree().create_timer(.2).timeout #padding between waves
	spawn_enemies(wave_data)
	
func retrieve_wave_data():
	var wave_data = [["SandTank", 3.0], ["SandTank", 1.0], ["RedTank", 1.0]]
	current_wave += 1
	enemies_in_wave = wave_data.size()
	return wave_data

func spawn_enemies(wave_data):
	for i in wave_data:
		var new_enemy = load("res://Scenes/Enemies/" + i[0] + ".tscn").instantiate()
		map.get_node("Path").add_child(new_enemy, true)
		await get_tree().create_timer(i[1]).timeout
		

#
# Game Control
#

func _on_PausePlay_pressed(): #pause and play the game with pause button
	if build_mode:
		cancel_build_mode() 
	if get_tree().is_paused():
		get_tree().paused = false
	elif current_wave == 0:
		current_wave +=1
		start_next_wave()
	else:
		get_tree().paused = true


func _on_FastForward_pressed():
	if build_mode:
		cancel_build_mode() 
	if Engine.get_time_scale() == 2.0:
		Engine.set_time_scale(1.0)
	else:
		Engine.set_time_scale(2.0)
