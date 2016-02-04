
extends Node2D

var store_tile_size
var store_size

func _init():
	store_tile_size = Vector2(50,50)
	store_size = Vector2(3,2)

func _ready():
	pass

func get_store_slot( pos ):
	var x = int(pos.x)/int(store_tile_size.x)
	var y = int(pos.y)/int(store_tile_size.y)
	return int(x + y*store_size.x)


func _on_Area2D_input_event( viewport, event, shape_idx ):
	if( event.type == 3 && event.button_mask == 1 && !mouse_manager.dragging):
		var store_slot = get_store_slot( event.pos-get_pos())
		if( store_slot > 4 ):
			return
		
		var essence_type = store_slot + 1
		if( store_slot == 4 ):
			essence_type = 0
		
		var essence = essence_factory.create_essence( [essence_type] )

		map.add_child(essence)
		mouse_manager.drag(essence)
		
