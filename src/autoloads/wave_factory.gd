
extends Node

func generate_wave_data( wave_nb, difficulty ):
	
	var monster_data_type
	if( wave_nb <= 3):
		monster_data_type = global.objects_data.monsters.index_by_name.normal;
	else :
		monster_data_type = (randi()%(global.objects_data.monsters.name_by_index.size()-1)) +1

	var monster_data = monster_factory.generate_monster_data(monster_data_type, wave_nb,difficulty)
	
	var monster_count = 10 * difficulty
	
	if( monster_data.type == global.objects_data.monsters.index_by_name.tank ):
		monster_count = round(monster_count * 0.5)
	elif( monster_data.type == global.objects_data.monsters.index_by_name.swarm ):
		monster_count = round(monster_count * 2)

	var monster_spawn_speed = 10 / monster_count
	
	var wave_data = global.scripts.WaveData.new(monster_data, monster_count, monster_spawn_speed)
	
	return wave_data

func create_wave(wave_data, map):
	return global.scripts.wave.new( wave_data, map )
