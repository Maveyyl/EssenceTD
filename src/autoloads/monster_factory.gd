
extends Node



func create_monster(monster_data, wave, entry_index):
	var monster = global.objects_data.monsters.scenes[monster_data.type].instance()
	monster.custom_init(monster_data, wave,  entry_index)

	return monster

func generate_monster_data(monster_type, wave_nb, difficulty):
	var monster_data = global.scripts.MonsterData.new()
	monster_data.type = monster_type

	monster_data.damage = round( 1 * difficulty * wave_nb )
	monster_data.movement_speed = 30
	monster_data.health_point_max = round( 20 * difficulty * wave_nb )
	monster_data.healing_speed = round( 1 * difficulty * wave_nb )
	monster_data.armor_max = round( 5 * difficulty * wave_nb )

	if( monster_data.type == global.objects_data.monsters.index_by_name.tank ):
		monster_data.movement_speed = round(monster_data.movement_speed * 0.5)
		monster_data.armor_max = round(monster_data.armor_max * 2)
		monster_data.health_point_max = round(monster_data.health_point_max * 2)
	elif( monster_data.type == global.objects_data.monsters.index_by_name.swarm ):
		monster_data.armor_max = round(monster_data.armor_max * 0.75)
		monster_data.health_point_max = round(monster_data.health_point_max * 0.75)
	elif( monster_data.type == global.objects_data.monsters.index_by_name.speed ):
		monster_data.movement_speed = round( monster_data.movement_speed * 1.5 )
	
	return monster_data