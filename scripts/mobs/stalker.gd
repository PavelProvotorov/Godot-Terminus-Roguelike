extends Enemy2D

func _ready():
	behaviours = [
		MeleeBehaviour.new(self, {}),
		MoveBehaviour.new(self, {
			"post_hook": funcref(self, "post_move")
		}),
		WanderBehaviour.new(self, {}),
	]
	attack_range = 1
	health = 4
	melee_damage = 3
	hide_enemy()
	
func _turn_started_hook() -> void:
	if target_nearby() and is_invisible(): 
		reveal_enemy()
	elif not target_nearby() and not is_invisible():
		pass

func post_move() -> void:
	if target_nearby() and is_invisible(): 
		reveal_enemy()

func reveal_enemy() -> GDScriptFunctionState:
	melee_damage -= 1
	set_collision_layer_bit(0, true)
	_audio.play_sound(self.position, Resources.SOUNDS.appear)
	return yield(play_appear_animation(), 'completed')

func hide_enemy() -> void:
	_sprite.modulate.a = 0
	set_collision_layer_bit(0, false)
	set_collision_layer_bit(2, true)

func target_nearby() -> bool:
	return path.size() >= 2 and path.size() <= 3

func target_unreachable() -> bool:
	return path.size() == 0
