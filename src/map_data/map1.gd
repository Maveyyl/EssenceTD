
extends Node2D
var global

var map_data
var tile_map 

func _ready():
	global = get_node("/root/global")
	
	tile_map = get_node("TileMap")

	map_data = global.scripts.MapData.new()

	map_data.map_size = Vector2(21,12)
	map_data.tile_size =  tile_map.get_cell_size()
	

	for i in range(0,25):
		map_data.waves_data.append( wave_factory.generate_wave_data(i+1, 1))
	
	
	map_data.initial_energy = 200

