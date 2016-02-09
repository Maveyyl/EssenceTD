
extends Node



var special_effects = SpecialEffects.new()
class SpecialEffects:
	var splash_range = 5
	var bounce= 0.1
	var bounce_range= 10
	var water_reloading= 0.01
	var armor_flat_reduction= 0.01
	
	func get_splash_range(special_power):
		return splash_range * special_power
	func get_bounce_range(special_power):
		return bounce_range * special_power
	func get_bounce_count(special_power):
		return ceil(bounce * special_power)
	func get_water_reloading_time( special_power ):
		return 1/(1+water_reloading * special_power)
	func get_armor_flat_reduction( special_power ):
		return 0.01*special_power



var wave = WaveLogic.new()
class WaveLogic:
	var monster_count = 10
	var spawn_speed = 10
	
	func get_monster_count( monster_type, wave_nb, difficulty ):
		var mc = monster_count * difficulty
		
		if( monster_type == global.objects_data.monsters.index_by_name.tank ):
			mc = monster_count * 0.5
		elif( monster_type == global.objects_data.monsters.index_by_name.swarm ):
			mc = monster_count * 2
			
		return round( mc )
		
	func get_spawn_speed( monster_count ):
		return spawn_speed / monster_count
		

var monster = MonsterLogic.new()
class MonsterLogic:
	# base stats
	var movement_speed = 30
	var base_damage = 1
	var base_health = 20
	var base_healing = 1
	var base_armor = 5
	var energy_reward = 5
	# multipliers per type
	var tank_reward = 3
	var tank_speed = 0.5
	var tank_damage = 2
	var tank_armor = 2
	var tank_health = 2
	var speed_speed = 1.5
	var swarm_health = 0.75
	var swarm_armor = 0.75
	var swarm_reward = 0.75

	
	func get_movement_speed(monster_type, wave_nb, difficulty):
		var ms = movement_speed
		if( monster_type == global.objects_data.monsters.index_by_name.tank ):
			ms = ms*tank_speed
		elif( monster_type == global.objects_data.monsters.index_by_name.speed ):
			ms = ms*speed_speed
		return round(ms)
			
	func get_armor_damage_reduction(armor, damage):
		return round( damage * 100/(100+armor) )
		
	func get_damage( monster_type, wave_nb, difficulty ):
		var damage =  base_damage * difficulty * wave_nb 
		if( monster_type == global.objects_data.monsters.index_by_name.tank ):
			damage *= tank_damage
		return round(damage)
		
	func get_health_max( monster_type, wave_nb, difficulty):
		var hp =  base_health * difficulty * wave_nb 
		
		if( monster_type == global.objects_data.monsters.index_by_name.tank ):
			hp = hp * tank_health
		elif( monster_type == global.objects_data.monsters.index_by_name.swarm ):
			hp = hp * swarm_health
			
		return round(hp)
		
	func get_healing_speed( monster_type, wave_nb, difficulty):
		return round( base_healing * difficulty * wave_nb )
		
	func get_armor_max( monster_type, wave_nb, difficulty):
		var armor_max =  base_armor * difficulty * wave_nb 
		
		if( monster_type == global.objects_data.monsters.index_by_name.tank ):
			armor_max = armor_max * tank_armor
		elif( monster_type == global.objects_data.monsters.index_by_name.swarm ):
			armor_max = armor_max * swarm_armor
			
		return round( armor_max )
		
	func get_energy_reward( monster_type, wave_nb, difficulty):
		var er = energy_reward * difficulty * wave_nb
		
		if( monster_type == global.objects_data.monsters.index_by_name.tank ):
			er = er * tank_reward
		elif( monster_type == global.objects_data.monsters.index_by_name.swarm ):
			er = er * swarm_reward
		
		return round(er)
		
		
		
		
var costs = Costs.new()
class Costs:
	var tower = 100
	var essence = 100
	