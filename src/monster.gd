extends Node2D

var wave

var monster_data
var health_point
var entry_index
var path
var path_step
var armor

var dead

func _init():
	dead = false

func _ready():
	set_fixed_process(true)
	pass

func custom_init( monster_data, wave, entry_index ):
	self.monster_data = monster_data
	self.wave = wave
	self.health_point = monster_data.health_point_max
	self.entry_index = entry_index
	self.armor = monster_data.armor_max
	path = map.map_data.paths[entry_index]
	path_step = 1
	
	
func _fixed_process(delta):
	
	if( path_step < path.size() ):
		var goal_tile = path[path_step]
		var tile_size = map.map_data.tile_size
		var goal_pos = Vector2( tile_size.x/2 + tile_size.x*goal_tile.x, tile_size.y/2 + tile_size.y*goal_tile.y)
		
		orient(goal_pos, delta)
		
		move(goal_pos, delta)
	
	
func orient(goal_pos, delta):
	if( get_pos().distance_to(goal_pos) > monster_data.movement_speed * delta ):
		get_node("Node2D Sprites").set_rot(get_pos().angle_to_point(goal_pos))

func move(goal_pos, delta):
	if( get_pos().distance_to(goal_pos) < monster_data.movement_speed * delta ):
		set_pos(goal_pos)
		path_step = path_step +1
	else:
		set_pos( get_pos() + Vector2( 0,-monster_data.movement_speed * delta ).rotated(get_node("Node2D Sprites").get_rot()))

func _draw():
	if( health_point != monster_data.health_point_max):
		var health_bar_middle = int( float(health_point) / float(monster_data.health_point_max) * 40)

		draw_line ( Vector2(-20,-20), Vector2(-20+health_bar_middle,-20), Color(0,1,0),3)
		draw_line ( Vector2(-20+health_bar_middle,-20), Vector2(20,-20), Color(1,0,0),3)

func apply_damage( damage ):
	damage = game_logic.monster.get_armor_damage_reduction(armor, damage)
	health_point = health_point - damage

	update() # draw health bar
	if( health_point <= 0 ):
		wave.monster_died()
		dead = true
		get_node("KinematicBody2D").clear_shapes()
		get_parent().remove_child(self)
		queue_free()
		
func armor_flat_reduce( reduction ):
	armor = armor - reduction
	if( armor < 0 ):
		armor = 0
		
func get_distance_to_base():
	if( path_step == path.size() ):
		return 0

	var next_tile_coord = path[path_step]
	var distance_to_next_tile = get_pos().distance_to( map.tile_coord_to_pos(next_tile_coord))
	return distance_to_next_tile + ( path.size()-path_step+1)* (map.map_data.tile_size.x + map.map_data.tile_size.y)/2

func _on_Area2D_input_event( viewport, event, shape_idx ):
	if( event.type == 3 && event.button_mask == 1):
		print("monster left click")
