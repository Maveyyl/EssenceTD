var wave_data
var map

var started
var completed
var annihilated 

var monsters_spawned_count
var monsters_dead_count
var monsters 
var spawn_counter


func _init( wave_data, map ):
	self.wave_data = wave_data
	self.map = map
	
	started = false
	completed = false
	annihilated = false
	
	monsters_spawned_count = 0
	monsters_dead_count = 0
	monsters = []
	spawn_counter = 0
	
func update(delta):

	if( started && !completed && !annihilated  ):
		spawn_counter = spawn_counter + delta
		if(  spawn_counter > wave_data.monster_spawn_time) :
			spawn_counter = 0
			create_monster()
			if( monsters_spawned_count == wave_data.monster_count ):
				completed = true
	
func create_monster():
	var entry_index = map.get_random_entry_index()
	
	var monster = monster_factory.create_monster( wave_data.monster_data, self, entry_index ) 
	# set pos of monster according to its entry index and the map's data
	var map_data = map.map_data
	monster.set_pos(Vector2(map_data.tile_size.x/2 + map_data.tile_size.x * map_data.entries[entry_index].x ,map_data.tile_size.y/2 +  map_data.tile_size.y * map_data.entries[entry_index].y)) 
	# do it after!
	map.add_child(monster)
	
	# notify map object
	map.monster_created()
	
	monsters.append(monster)
	monsters_spawned_count = monsters_spawned_count + 1
	
func monster_died( ):
	monsters_dead_count = monsters_dead_count + 1
	if( wave_data.monster_count == monsters_dead_count ):
		annihilated = true
	map.monster_died()
	
func start():
	started = true
	