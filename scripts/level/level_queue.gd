extends TileMap
class_name Queue

onready var _tree:SceneTree = get_tree()
var queue:Array = []

func _init():
	Events.connect("end_turn", self, "_on_end_turn")
	Events.connect("force_queue_processing", self, "_on_force_queue_processing")
	connect("tree_exiting", self, "_on_tree_exiting")
	Callback.add(Callback.TYPE.PROCESS_QUEUE, funcref(self, "process_queue"), self)
	
func process_queue() -> void:
	if queue.size() == 0:
		build_queue()
		
	var next_node = queue[0]
#	print("PROCESSING QUEUE: ", next_node)
	if self.has_node(str(next_node)):
		print("CURRENTLY MOVING: ", next_node)
		next_node.emit_signal("start_turn")
	else:
#		print("QUEUE NODE DOES NOT EXIST: ", next_node)
		queue.erase(next_node)
		process_queue()

func build_queue() -> void:
	print("BUILDING QUEUE BY: ", self)
	queue = []
	queue.append_array(_tree.get_nodes_in_group("ENTITY_AI"))
	queue.append_array(_tree.get_nodes_in_group("PLAYER"))
	print("QUEUE:", queue)

func _on_end_turn(node:Node) -> void:
	queue.erase(node)
	Callback.trigger(Callback.TYPE.PROCESS_QUEUE, [])

func _on_force_queue_processing() -> void:
	print("----------------------------------")
	print("FORCING QUEUE PROCESSING")
	process_queue()

func _on_tree_exiting():
	Events.disconnect("end_turn", self, "_on_end_turn")
