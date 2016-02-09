

var map_size 
var tile_size
var tiles_data = []
var entries = []
var paths = []
var bases = []
var waves_data = []
var initial_energy


func _init():
	pass

func custom_init( tilemap ):
	var tiles = []
	tiles_data.resize(map_size.x*map_size.y)
	tiles.resize(map_size.x*map_size.y)
	for x in range(0, map_size.x):
		for y in range(0, map_size.y):
			tiles_data[x+y*map_size.x] = tilemap.get_cell(x,y)
			tiles[x+y*map_size.x] = global.scripts.tile.new( tilemap.get_cell(x,y), Vector2(x, y) )
			
			# set bases
			if ( tiles[x+y*map_size.x].tile_type == global.objects_data.tiles.index_by_name["base"] ):
				bases.append(Vector2(x,y))
				
	# set entries
	for x in range(0, map_size.x):
		var y = 0
		if( tiles[x+y*map_size.x].tile_type == global.objects_data.tiles.index_by_name["path"] ):
			entries.append(Vector2(x,y))
		y = map_size.y -1
		if( tiles[x+y*map_size.x].tile_type == global.objects_data.tiles.index_by_name["path"] ):
			entries.append(Vector2(x,y))
		
	for y in range(0, map_size.y):
		var x = 0
		if( tiles[x+y*map_size.x].tile_type == global.objects_data.tiles.index_by_name["path"] ):
			entries.append(Vector2(x,y))
		x = map_size.x -1
		if( tiles[x+y*map_size.x].tile_type == global.objects_data.tiles.index_by_name["path"] ):
			entries.append(Vector2(x,y))
		
	# compute and set set paths
	for i in range(0, entries.size()):
		for j in range(0, bases.size()):
			var path = PathFinding.A_star( tiles, entries[i], bases[j], map_size, global.objects_data.tiles.passible_tiles )
			paths.append(path)
	
	return tiles