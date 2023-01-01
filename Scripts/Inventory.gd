extends GridContainer

const item_slots_max = 6
const item_slots_min = 0
var item_slots:int = item_slots_min

func _ready():
	pass

func clear_inventory():
	for child in self.get_children():
		self.remove_child(child)
		child.queue_free()
	pass
