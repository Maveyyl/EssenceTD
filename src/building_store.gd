
extends Node2D

var store_tile_size
var store_size

func _init():
	store_tile_size = Vector2(50,50)
	store_size = Vector2(3,2)


func get_store_slot( pos ):
	var x = int(pos.x)/int(store_tile_size.x)
	var y = int(pos.y)/int(store_tile_size.y)
	return int(x + y*store_size.x)



func _on_Area2D_input_event( viewport, event, shape_idx ):
	if( event.type == 3 && event.button_mask == 1):
		var store_slot = get_store_slot( event.pos-get_pos())
		if( store_slot > global.objects_data.buildings.scenes.size() ):
			return
		
		var building_type = store_slot
		
		if( building_type == 0 ):
			map.build_tower()
		