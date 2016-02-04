
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	var animation_walk = get_node("AnimationPlayer Walk")
	animation_walk.set_current_animation( "swarm_monster_walk" )
	animation_walk.set_speed(get_parent().monster_data.movement_speed/10)
	animation_walk.play()
	var animation_head = get_node("AnimationPlayer Head")
	animation_head.set_current_animation( "swarm_monster_head" )
	animation_head.play()
	pass

