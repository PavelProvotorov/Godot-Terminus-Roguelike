extends TileMap
class_name Queue

var queue:Array = []
onready var _level:Level = get_parent()
onready var _tree:SceneTree = get_tree()

func _init():
	Events.connect("level_generation_complete", self, "_on_level_generation_complete")
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
	print("BUILDING QUEUE")
	queue = []
	queue.append_array(_tree.get_nodes_in_group("PLAYER"))
	queue.append_array(_tree.get_nodes_in_group("WANDERING"))
	queue.append_array(_tree.get_nodes_in_group("ACTIVE"))
	print("QUEUE:", queue)
	

func _on_level_generation_complete() -> void:
	print("----------------------------------")
	print("LEVEL GENERATION COMPLETE")
	build_queue()
	process_queue()

func _on_end_turn(node:Node) -> void:
	print("----------------------------------")
	print("TURN ENDED BY: ", node)
	queue.erase(node)
	process_queue()
