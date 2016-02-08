
extends Node

func generate_wave_data( wave_nb, difficulty ):
	
	var monster_data_type
	if( wave_nb <= 3):
		monster_data_type = global.objects_data.monsters.index_by_name.normal;
	else :
		monster_data_type = (randi()%(global.objects_data.monsters.name_by_index.size()-1)) +1

	var monster_data = monster_factory.generate_monster_data(monster_data_type, wave_nb,difficulty)
	
	var monster_count = game_logic.wave.get_monster_count(monster_data_type, wave_nb, difficulty)
	var monster_spawn_speed = game_logic.wave.get_spawn_speed( monster_count )
	
	var wave_data = global.scripts.WaveData.new(monster_data, monster_count, monster_spawn_speed)
	
	return wave_data

func create_wave(wave_data, map):
	return global.scripts.wave.new( wave_data, map )
