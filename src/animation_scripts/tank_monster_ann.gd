
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	var animation_walk = get_node("AnimationPlayer Walk")
	animation_walk.set_current_animation( "tank_monster_walk" )
	animation_walk.set_speed(get_parent().monster_data.movement_speed/10)
	animation_walk.play()
	pass


