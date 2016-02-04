extends Node2D

var inventory_tile_size
var inventory_size 
var objects

func _init():
	inventory_tile_size = Vector2(50,50)
	inventory_size = Vector2(3,6)
	objects = []
	objects.resize(inventory_size.x*inventory_size.y)
	

func _ready():
	pass

func get_inventory_slot( pos ):
	var x = int(pos.x)/int(inventory_tile_size.x)
	var y = int(pos.y)/int(inventory_tile_size.y)
	return x + y*inventory_size.x
	
	
func get_inventory_slot_center( pos ):
	var x = int(pos.x)/int(inventory_tile_size.x) * inventory_tile_size.x + inventory_tile_size.x/2
	var y = int(pos.y)/int(inventory_tile_size.y) * inventory_tile_size.y + inventory_tile_size.y/2
	return Vector2(x,y)

func _on_Area2D_input_event( viewport, event, shape_idx ):
	if( event.type == 3 && event.button_mask == 1):
		var inventory_slot = get_inventory_slot(event.pos-get_pos())
		var inventory_object = objects[inventory_slot]
			
		var m_object = mouse_manager.drag(inventory_object)
		objects[inventory_slot] = m_object
		if( m_object ):
			m_object.get_parent().remove_child(m_object)
			add_child(m_object)
			m_object.set_pos( get_inventory_slot_center(event.pos-get_pos()))
			
		

