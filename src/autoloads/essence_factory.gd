
extends Node

func _init():
	Globals.set("essence_factory", self)

func _ready():
	pass


func create_essence(essence_types):
	if( essence_types.size() == 1 ):
		var essence = global.objects_data.essences.scenes[essence_types[0]].instance()
		
		essence.damage = 5
		essence.reloading_time = 0.5
		essence.attack_range = 200
		essence.special_power = 5
		essence.custom_init( essence_types )
		
		return essence
	