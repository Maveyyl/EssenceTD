
extends Node2D

var building_type
var essence
var tile


func _ready():
	pass

func custom_init( building_type, tile, pos):
	self.building_type = building_type
	self.tile = tile
	essence = null
	set_pos(pos)
	
func set_essence(essence):
	if( essence == null ):
		return
	self.essence = essence
	
	essence.get_parent().remove_child( essence )
	add_child(essence)
			
	essence.set_in_building(self)
	essence.set_pos(Vector2(0,0))
	
func unset_essence():
	var previous_essence = essence
	essence = null
	return previous_essence

func select():
	if( essence ):
		essence.select()
		
func unselect():
	if(essence):
		essence.unselect()