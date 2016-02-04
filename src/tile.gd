var tile_type
var building
var coord


func _init(tile_type, coord):
	self.tile_type = tile_type
	self.coord = coord
	building = null
	
func select():
	if( building ):
		building.select()
		
func unselect():
	if(building):
		building.unselect()