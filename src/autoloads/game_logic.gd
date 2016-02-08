
extends Node

# special effects
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


var monster = MonsterLogic.new()
class MonsterLogic:
	var movement_speed = 30
	
	func get_movement_speed(monster_type, wave_nb, difficulty):
		var ms = movement_speed
		if( monster_type == global.objects_data.monsters.index_by_name.tank ):
			ms = round(ms*0.5)
		elif( monster_type == global.objects_data.monsters.index_by_name.speed ):
			ms = round(ms*1.5)
		return ms
			
	func get_armor_damage_reduction(armor, damage):
		return round( damage * 100/(100+armor) )
		
	func get_damage( monster_type, wave_nb, difficulty ):
		var damage = round( 1 * difficulty * wave_nb )
		if( monster_type == global.objects_data.monsters.index_by_name.tank ):
			damage *= 2
		return damage
		
	func get_health_max( monster_type, wave_nb, difficulty):
		var hp = round( 20 * difficulty * wave_nb )
		
		if( monster_type == global.objects_data.monsters.index_by_name.tank ):
			hp = round(hp * 2)
		elif( monster_type == global.objects_data.monsters.index_by_name.swarm ):
			hp = round(hp * 0.75)
			
		return hp
		
	func get_healing_speed( monster_type, wave_nb, difficulty):
		return round( 1 * difficulty * wave_nb )
		
	func get_armor_max( monster_type, wave_nb, difficulty):
		var armor_max = round( 5 * difficulty * wave_nb )
		
		if( monster_type == global.objects_data.monsters.index_by_name.tank ):
			armor_max = round(armor_max * 2)
		elif( monster_type == global.objects_data.monsters.index_by_name.swarm ):
			armor_max = round(armor_max * 0.75)
			
		return armor_max