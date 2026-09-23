extends Node

var processing: bool = false
var game_turn_ended: bool = false
var queue = []
var listeners = {}

enum TYPE {
	PROCESS_QUEUE = 0,
	TURN_SKIP = 1,
	DAMAGE_RECEIVED = 2,
}

func _process(delta) -> void:
	if not game_turn_ended and not processing:
		return

	if queue.size() > 0:
		processing = true
		var event = queue.pop_front()
		var event_idx = event.idx
		var event_args = event.get('args', [])
		
		if listeners.has(event_idx):
			for listener in listeners[event_idx].duplicate():
				var callback: FuncRef = listener.callback
				if callback is FuncRef and callback.is_valid():
#					print("PROCESSING CALLBACK: ", callback.function, " | ", event_args)
					var state = callback.call_funcv(event_args)
					if state is GDScriptFunctionState and state.is_valid():
						yield(state, "completed")
		processing = false

		if queue.size() == 0:
			game_turn_ended = false
			Events.emit_signal("force_queue_processing")

func add(idx: int, callback: FuncRef, node: Node) -> void:
	if not listeners.has(idx):
		listeners[idx] = []

	listeners[idx].append({
		"callback": callback,
		"node": node,
	})
	
func remove(idx: int, node: Node, callback: FuncRef = null) -> void:
	if not listeners.has(idx):
		return

	var list = listeners[idx]
	for i in range(list.size() - 1, -1, -1):
		var listener = list[i]
		if listener.node == node and (callback == null or listener.callback == callback):
			list.remove(i)
			
func remove_all(node: Node) -> void:
	for idx in listeners:
		remove(idx, node)

func active_processing() -> bool:
	return queue.size() > 0 or processing or game_turn_ended

func trigger(idx: int, args: Array = []) -> void:
	print("TRIGGERED CALLBACK: ", TYPE.find_key(idx), " | ", idx)

	if idx == TYPE.PROCESS_QUEUE:
		if not active_processing():
			Events.emit_signal("force_queue_processing")
		else:
			game_turn_ended = true
		return

	queue.push_back({
		"idx": idx,
		"args": args,
	})
