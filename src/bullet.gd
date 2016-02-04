
extends Node2D

var essence
var damage
var speed
var special_power
var bullet_types

var target
var bounce

func _init():
	speed = 200
	pass

func _ready():
	set_fixed_process(true)
	pass
	
func custom_init(essence, target, damage, special_power, bullet_types):
	self.essence = essence
	self.damage = damage
	self.special_power = special_power
	self.bullet_types = bullet_types
	self.target = target
	self.bounce = 0
	


	
func _fixed_process(delta):
	
	if(  target == null || target.dead  ):
		queue_free()
		return

	if( get_pos().distance_to(target.get_pos()) < speed*delta):
		set_pos( target.get_pos() )
		trigger(target)
		queue_free()

	var movement = Vector2(0, -speed*delta)
	var angle = get_pos().angle_to_point( target.get_pos() )
	set_rot( angle )
	movement = movement.rotated(  angle )
	
	set_pos( get_pos()+movement )
	

func trigger(target):
	var on_hit_monsters

	if( bullet_types.find( global.objects_data.essences.index_by_name["earth"]  ) != -1):

		# get monsters at bounce range
		var monsters = map.get_monsters_in_circle( get_pos(), global.get_bounce_range(special_power), target)
		var bounce_monster = null
		# get the closest alive non targeted monster
		for y in range (0, monsters.size()):
			if( !monsters[y].dead && monsters[y] != target):
				bounce_monster = monsters[y]
				break
		# create a new bullet aimed at him
		if( bounce_monster && bounce < global.get_bounce_count(special_power)):
			var bullet_scene = global.objects_data.bullets.scenes[0].instance()
			map.add_child(bullet_scene)
			bullet_scene.custom_init(essence, bounce_monster, damage, special_power, bullet_types)
			bullet_scene.set_pos(get_pos())
			bullet_scene.bounce = self.bounce + 1

	if( bullet_types.find( global.objects_data.essences.index_by_name["fire"]  ) != -1):
		on_hit_monsters = map.get_monsters_in_circle( get_pos(), global.get_splash_range(special_power), target)
		

	if( bullet_types.find( global.objects_data.essences.index_by_name["water"]  ) != -1):
		var armor_flat_reduction = global.get_armor_flat_reduction(special_power)

		target.armor_flat_reduce(armor_flat_reduction)
		if( on_hit_monsters != null ):
			for y in range(0, on_hit_monsters.size()):
				on_hit_monsters[y].armor_flat_reduce(armor_flat_reduction)

	target.apply_damage(damage)
	if( on_hit_monsters != null):
		for y in range(0, on_hit_monsters.size()):
			on_hit_monsters[y].apply_damage(damage)