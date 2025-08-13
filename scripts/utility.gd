extends Node
class_name Utility

func call_lifecycle_hook(hook:FuncRef):
	if hook is FuncRef and hook.is_valid():
		return hook.call_func()
