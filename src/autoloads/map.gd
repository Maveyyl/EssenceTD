
extends Node2D

onready var map_ui = get_node("Node2D MapUI")

var map_scene
var map_data 
var tiles
var waves
var wave_completed
var wave_started
var monster_count

var initialized
var tile_hover
var tile_select

var selected_tile

func _init():
	waves = []
	wave_started = 0

	wave_started = 0
	wave_completed = 0
	monster_count = 0

func _ready():
	set_fixed_process(true)
	
	# sprites used to highlight hovered tile and selected tile
	tile_hover = get_node("TileHover")
	tile_select = get_node("TileSelect")
	
func custom_init(map_id):
	# instantiate specific map that contains a tilemap
	map_scene = global.objects_data.maps.scenes[map_id].instance();
	self.add_child( map_scene )
	
	# get the map data
	map_data = map_scene.map_data
	
	# init the map data with the tilemap 
	tiles = map_data.custom_init(map_scene.tile_map)
	
	# create the waves according to waves data of the map
	for i in range(0, map_data.waves_data.size()):
		waves.append( wave_factory.create_wave(map_data.waves_data[i], self) )
	
	# set the collision shape of the map
	var map_pixel_size = map_data.tile_size * map_data.map_size
	
	get_node("Area2D").set_pos( map_pixel_size/2)
	get_node("Area2D").get_shape(0).set_extents(map_pixel_size/2)
	

func _fixed_process(delta):
	if( input_manager.build_tower ):
		build_tower()
	if( input_manager.next_wave ):
		start_next_wave()
	for i in range(0, wave_started):
		waves[i].update(delta)

func start_next_wave():
	if( wave_started >= waves.size()):
		return
	waves[wave_started].start()
	wave_started = wave_started + 1
	
	map_ui.update()
	
	
func get_random_entry_index():
	return floor(randf() * map_data.entries.size())
	
func monster_created( ):
	monster_count = monster_count + 1
	map_ui.update()

	
func monster_died( ):
	monster_count = monster_count - 1
	map_ui.update()



func get_tile( coord ):
	return tiles[ coord.x+coord.y*map_data.map_size.x]
	
func tile_coord_to_pos( coord ):
	coord.x = coord.x * map_data.tile_size.x + map_data.tile_size.x/2
	coord.y = coord.y * map_data.tile_size.y + map_data.tile_size.y/2
	return coord

func _on_StaticBody2D_mouse_enter():
	tile_hover.show()


func _on_StaticBody2D_input_event( viewport, event, shape_idx ):
	if( shape_idx != 0 ):
		return
	
	
	var tile_coord = Vector2(int(event.pos.x) / int(map_data.tile_size.x), int(event.pos.y) / int(map_data.tile_size.y))
	var tile_center_pos = tile_coord * map_data.tile_size + map_data.tile_size/2 
	
	# mouse move
	if( event.type == 2 ):
		tile_hover.set_pos(tile_center_pos)
	# left click
	if( event.type == 3 && event.button_mask == 1):
		var clicked_tile = get_tile(tile_coord)
		if( clicked_tile.building ):
			var b_essence = clicked_tile.building.unset_essence()
			var a_essence = mouse_manager.drag(b_essence)
			clicked_tile.building.set_essence(a_essence)
			
		
	# right click
	if( event.type == 3 && event.button_mask == 2):
		if( selected_tile ):
			selected_tile.unselect()
		
		selected_tile = get_tile(tile_coord)
		
		tile_select.set_pos(tile_center_pos)
		tile_select.show()
		if( selected_tile ):
			selected_tile.select()


func _on_StaticBody2D_mouse_exit():
	tile_hover.hide()
	



func build_tower( ):
	if( selected_tile && !selected_tile.building ):
		var tower = building_factory.create_tower(map, selected_tile, tile_coord_to_pos( selected_tile.coord))
		selected_tile.building = tower
		map.add_child(tower)
		

func get_monsters_in_circle(center, radius, exclude):
	var monsters = []
	var distances = {}
	for i in range(0, waves.size()):
		for y in range(0, waves[i].monsters.size()):
			var monster = waves[i].monsters[y]
			
			if( monster.dead || ( exclude && exclude == monster )):
				continue
				
			var distance = center.distance_to( monster.get_pos() )
			if( center.distance_to( monster.get_pos() ) <= radius ):
				distances[monster] = distance
				for z in range(0, monsters.size()+1):
					if( z == monsters.size() || distances[monsters[z]] > distance ):
						monsters.insert(z,monster)
						break
				if( monsters.size() == 0 ):
					monsters.append(monster)

	return monsters
	
	


