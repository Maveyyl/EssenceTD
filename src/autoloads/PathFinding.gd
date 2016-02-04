extends Node

class PathFindingNode:
	var index
	var cost
	var heuristic
	var root
	
func A_star( tiles, start_point, end_point, map_size, passible_terrain):
	var start_time = OS.get_ticks_msec()
	
	var end_point_index = coord2d_to_index(end_point, map_size )
	var treated_set = []
	var to_treat_set = []
	var nodes = {}
	var a = []
	
	add_to_treat( coord2d_to_index(start_point, map_size ), 0, start_point.distance_to(end_point), to_treat_set, nodes)

	while ( !to_treat_set.empty()):
		var current_index = to_treat_set[0]
		to_treat_set.remove(0)
		treated_set.append( current_index )
		
		if( current_index == end_point_index ):
			var stop_time = OS.get_ticks_msec()
			# print("execution_time: ", stop_time - start_time    )
			return reconstitute_path(end_point_index, nodes, map_size)
		
		var neighbours = get_neighbours_index( current_index, map_size )
		
		for i in range(0, neighbours.size() ):
			var neighbour_index = neighbours[i]
			if( passible_terrain[ tiles[ neighbour_index ].tile_type ] ):
				if( treated_set.find( neighbour_index ) >= 0 ):
					continue
				var tmp_cost  = nodes[current_index].cost +1;

				if( to_treat_set.find( neighbour_index ) < 0 ):
					add_to_treat(neighbour_index , tmp_cost, tmp_cost + index_to_coord2d(neighbour_index,map_size).distance_to( end_point), to_treat_set, nodes)
					nodes[neighbour_index].root = current_index
				elif ( tmp_cost <= nodes[neighbour_index].cost ):
					nodes[neighbour_index].root = current_index
					
	# error
	return []

func reconstitute_path (end_point_index, nodes, map_size):
	var current_index = end_point_index
	var path = []
	path.insert(0,  index_to_coord2d(end_point_index, map_size))
	
	while( nodes[current_index].root ):
		path.insert(0, index_to_coord2d(nodes[current_index].root, map_size))
		current_index = nodes[current_index].root
	
	return path
	

func add_to_treat( index, cost, heuristic, to_treat_set, nodes):

	var node = PathFindingNode.new()
	node.index = index
	node.cost = cost
	node.heuristic = heuristic
	nodes[index] = node
	var added = false
	
	for i in range(0, to_treat_set.size()):
		if( compare( nodes[index], nodes[to_treat_set[i]] ) < 0 ):
			to_treat_set.insert(i, index)
			break
	if( to_treat_set.size() == 0 || !added ):
		to_treat_set.append(index)

func compare( node1, node2):
	if( node1.heuristic > node2. heuristic ):
		return 1
	elif( node1.heuristic < node2. heuristic ):
		return -1
	else:
		if( node1.cost < node2.cost):
			return 1
		elif( node1.cost > node2.cost):
			return -1
		else:
			if( node1.index > node2.index ):
				return 1
			else:
				return -1


func coord2d_to_index( coord, size ):
	return coord.y * size.x + coord.x

func index_to_coord2d( index, size):	
	return Vector2(int(index) % int(size.x), int(index) / int(size.x))

func check_bounds( coord, size):
	return coord.x >= 0 && coord.x < size.x && coord.y >= 0 && coord.y < size.y

func get_neighbours_index(index ,size):
	var coord = index_to_coord2d( index, size)
	var neighbours = []
	
	var neighbours_coord = [
		Vector2(coord.x-1, coord.y), # left
		Vector2(coord.x, coord.y-1), # top
		Vector2(coord.x+1, coord.y), # right
		Vector2(coord.x, coord.y+1) # bottom
	]
	
	for i in range(0,4):
		if( check_bounds( neighbours_coord[i], size) ):
			neighbours.append( coord2d_to_index( neighbours_coord[i], size ) )
		
	return neighbours
		
