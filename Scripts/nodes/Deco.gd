extends TileMap

func _on_Logic_add_border(vector,colour):
	set_cellv(vector,colour,false,false,false)
	update_bitmask_area(vector)
