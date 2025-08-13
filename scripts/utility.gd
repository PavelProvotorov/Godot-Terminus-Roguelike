extends Node
class_name Utility

func call_lifecycle_hook(hook:FuncRef):
	if hook is FuncRef and hook.is_valid():
		return hook.call_func()

func get_chance(percentage:int) -> bool:
  return percentage > 0 and randi() % 100 < percentage
