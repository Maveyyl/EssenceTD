
extends Node2D

var essence_types
var damage
var init_reloading_time
var reloading_time
var attack_range
var special_power
var kill_count
var level
var behavior

var reloading_counter

var target
var monsters_at_range
var building

var dragged
var item
var selected



func _init():
	essence_types = []
	monsters_at_range = []
	dragged = false
	item = false
	

func _ready():
	set_fixed_process(true)
	pass

func custom_init(essence_types):
	self.essence_types = essence_types;
	reloading_counter = 0
	# get_node("Area2D Range").get_shape(0).set_radius(attack_range)
	var circle = CircleShape2D.new()
	circle.set_radius(attack_range)
	# get_node("Area2D Range").remove_shape ( 0 )
	get_node("Area2D Range").add_shape( circle ) 
	
	init_reloading_time = reloading_time
	if( essence_types.find( global.objects_data.essences.index_by_name["air"]  ) != -1):
		reloading_time =  init_reloading_time * global.get_water_reloading_time(special_power)
		

func _fixed_process(delta):
	if( !(dragged || item) ):
		reloading_counter = reloading_counter + delta
		
		if( (!target || target.dead ||  monsters_at_range.find(target) < 0) &&  monsters_at_range.size() > 0 ):
			target = get_closest_monster_to_base(monsters_at_range)

		if(target && !target.dead &&  reloading_counter > reloading_time):
			reloading_counter = 0
			shoot()

func shoot():
	var bullet_scene = global.objects_data.bullets.scenes[0].instance()
	map.add_child(bullet_scene)
	bullet_scene.custom_init(self, target, damage, special_power, essence_types)
	bullet_scene.set_pos(get_parent().get_pos())

func get_closest_monster_to_base(monsters_at_range):
	var best_monster = null
	var best_distance = -1
	for i in range(0,monsters_at_range.size()):
		var distance = monsters_at_range[i].get_distance_to_base()
		if( distance < best_distance || best_distance == -1 ):
			best_monster = monsters_at_range[i]
			best_distance = distance
	return best_monster

func set_dragged():
	dragged = true
	item = false
	building = null
	target = null
	
func set_item():
	dragged = false
	item = true
	building = null
	target = null

func set_in_building(building):
	self.building = building
	dragged = false
	item = false
	target = null

func _on_Area2D_body_enter_shape( body_id, body, body_shape, area_shape ):
	monsters_at_range.append(body.get_parent())


func _on_Area2D_body_exit_shape( body_id, body, body_shape, area_shape ):
	monsters_at_range.remove( monsters_at_range.find(body.get_parent()))
	if( body.get_parent() == target):
		target = null
			

func _draw():
	if( selected ) :
		var e = 128
		var angle = deg2rad(float(360)/float(e))
		var initial_vector = Vector2(0, attack_range)
		for i in range(0,e):
			draw_line( initial_vector.rotated(i*angle), initial_vector.rotated((i+1)*angle), Color(0,0,0), 2)
			
		

func select():
	selected = true
	update()
	
func unselect():
	update()
	selected = false
