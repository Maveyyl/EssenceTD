
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	var animation_walk = get_node("AnimationPlayer Walk")
	animation_walk.set_current_animation( "normal_monster_walk" )
	animation_walk.set_speed(get_parent().monster_data.movement_speed/10)
	animation_walk.play()
	var animation_eyes = get_node("AnimationPlayer Eyes")
	animation_eyes.set_current_animation( "normal_monster_eyes" )
	animation_eyes.play()
	pass


