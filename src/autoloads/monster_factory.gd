
extends Node



func create_monster(monster_data, wave, entry_index):
	var monster = global.objects_data.monsters.scenes[monster_data.type].instance()
	monster.custom_init(monster_data, wave,  entry_index)

	return monster

func generate_monster_data(monster_type, wave_nb, difficulty):
	var monster_data = global.scripts.MonsterData.new()
	
	monster_data.type = monster_type

	monster_data.damage = game_logic.monster.get_damage(monster_type, wave_nb, difficulty)
	monster_data.movement_speed = game_logic.monster.get_movement_speed(monster_type, wave_nb,difficulty)
	monster_data.health_point_max = game_logic.monster.get_health_max(monster_type, wave_nb, difficulty)
	monster_data.healing_speed = game_logic.monster.get_healing_speed(monster_type, wave_nb, difficulty)
	monster_data.armor_max = game_logic.monster.get_armor_max( monster_type,wave_nb, difficulty )
	
	return monster_data