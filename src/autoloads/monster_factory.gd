
extends Node



func create_monster(monster_data, wave, entry_index):
	var monster = global.objects_data.monsters.scenes[monster_data.type].instance()
	monster.custom_init(monster_data, wave,  entry_index)

	return monster
