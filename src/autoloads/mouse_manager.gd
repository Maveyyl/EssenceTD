
extends Node2D

var dragged_object
var dragging

func _init():
	dragging = false

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if( dragging ):
		dragged_object.set_pos(get_viewport().get_mouse_pos()) 


func drag( object ):
	var previous_object = null
	if( dragging ):
		previous_object = drop()
	
	if( object != null ):
		dragged_object = object
		dragged_object.set_dragged()
		dragging = true
	
		object.get_parent().remove_child( object )
		add_child(object)
	
	return previous_object
	
func drop():
	var previous_object = dragged_object
	dragged_object = null
	dragging = false
	return previous_object

