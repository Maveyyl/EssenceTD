
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


