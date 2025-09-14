extends TileMap
class_name Queue

onready var _tree:SceneTree = get_tree()
var queue:Array = []

func _init():
	Events.connect("end_turn", self, "_on_end_turn")
	
func process_queue() -> void:
	
	if queue.size() == 0:
		build_queue()
		
	var next_node = queue[0]
	if self.has_node(str(next_node)):
		print("CURRENTLY MOVING: ", next_node)
		next_node._on_start_turn()
	else:
		print("QUEUE NODE DOES NOT EXIST: ", next_node)
		queue.erase(next_node)
		process_queue()

func build_queue() -> void:
	print("BUILDING QUEUE BY: ", self)
	queue = []
	
#	var children = get_children()
#	for child in children:
#		if child.is_in_group("PLAYER") \
#		or child.is_in_group("WANDERING") \
#		or child.is_in_group("ACTIVE"):
#			queue.append(child)
	queue.append_array(_tree.get_nodes_in_group("PLAYER"))
	queue.append_array(_tree.get_nodes_in_group("WANDERING"))
	queue.append_array(_tree.get_nodes_in_group("ACTIVE"))
	print("QUEUE:", queue)

func _on_end_turn(node:Node) -> void:
	print("----------------------------------")
	print("TURN ENDED BY: ", node)
	queue.erase(node)
	process_queue()
	
#func sort_queue() -> Array:
#	return []
