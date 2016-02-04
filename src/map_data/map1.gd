
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
	
	#var monster_data = global.scripts.MonsterData.new()
	#monster_data.monster_type = 4;
	#monster_data.damage = 1
	#monster_data.movement_speed = 30
	#monster_data.health_point_max = 15
	#monster_data.healing_speed = 1
	#monster_data.armor_max = 1
	
	#map_data.waves_data.append( global.scripts.WaveData.new( monster_data, 5, 1) )
	#map_data.waves_data.append( global.scripts.WaveData.new( monster_data, 5, 1) )
	#map_data.waves_data.append( global.scripts.WaveData.new( monster_data, 5, 1) )

	for i in range(0,25):
		map_data.waves_data.append( wave_factory.generate_wave_data(i, 1))
	
	
	

