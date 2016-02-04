
extends Node

func generate_wave_data( wave_nb, difficulty ):
	var monster_data = global.scripts.MonsterData.new()
	
	if( wave_nb <= 3):
		monster_data.type = global.objects_data.monsters.index_by_name.normal;
	else :
		monster_data.type = (randi()%(global.objects_data.monsters.name_by_index.size()-1)) +1

	monster_data.damage = round( 1 * difficulty * wave_nb )
	monster_data.movement_speed = 30
	monster_data.health_point_max = round( 15 * difficulty )
	monster_data.healing_speed = round( 1 * difficulty * wave_nb )
	monster_data.armor_max = round( 5 * difficulty * wave_nb )
	
	var monster_count = 10 * difficulty
	
	if( monster_data.type == global.objects_data.monsters.index_by_name.normal ):
		pass
	elif( monster_data.type == global.objects_data.monsters.index_by_name.tank ):
		monster_data.movement_speed = round(monster_data.movement_speed * 0.5)
		monster_data.armor_max = round(monster_data.armor_max * 2)
		monster_data.health_point_max = round(monster_data.health_point_max * 2)
		monster_count = round(monster_count * 0.5)
		pass
	elif( monster_data.type == global.objects_data.monsters.index_by_name.swarm ):
		monster_data.armor_max = round(monster_data.armor_max * 0.75)
		monster_data.health_point_max = round(monster_data.health_point_max * 0.75)
		monster_count = round(monster_count * 2)
		pass
	elif( monster_data.type == global.objects_data.monsters.index_by_name.speed ):
		monster_data.movement_speed = round( monster_data.movement_speed * 1.5 )
		pass

	var monster_spawn_speed = 10 / monster_count
	
	var wave_data = global.scripts.WaveData.new(monster_data, monster_count, monster_spawn_speed)
	return wave_data

func create_wave(wave_data, map):
	return global.scripts.wave.new( wave_data, map )
