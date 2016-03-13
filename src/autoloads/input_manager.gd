extends Node2D


var build_tower
var build_tower_state

var next_wave
var next_wave_state

var destroy_building
var destroy_building_state

func _init():
	Globals.set("input_manager", self)
	

func _ready():
	set_fixed_process(true)


func _fixed_process(delta):
	if( Input.is_action_pressed("build_tower") ):
		if( !build_tower_state):
			build_tower = true
		else:
			build_tower = false
		build_tower_state = true
	if( !Input.is_action_pressed("build_tower") ):
		build_tower_state = false
		build_tower = false


	if( Input.is_action_pressed("next_wave") ):
		if( !next_wave_state):
			next_wave = true
		else:
			next_wave = false
		next_wave_state = true
	if( !Input.is_action_pressed("next_wave") ):
		next_wave_state = false
		next_wave = false
		
		
	if( Input.is_action_pressed("destroy_building") ):
		if( !destroy_building_state):
			destroy_building = true
		else:
			destroy_building = false
		destroy_building_state = true
	if( !Input.is_action_pressed("destroy_building") ):
		destroy_building_state = false
		destroy_building = false
