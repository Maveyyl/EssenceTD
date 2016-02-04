
extends Node

func create_tower(map, selected_tile, tile_pos):
	var building_type = global.objects_data.buildings.index_by_name.tower
	var tower_scene = global.objects_data.buildings.scenes[building_type].instance()
	tower_scene.custom_init( building_type, selected_tile, tile_pos )
	
	return tower_scene


