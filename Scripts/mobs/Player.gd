extends Mob2D

onready var NODE_RAYCAST_MOB = $RayCastMob
onready var NODE_RAYCAST_FOG = $RayCastFog
onready var NODE_CAMERA_2D = $Camera2D

var AI_state = Global.AI_STATE_LIST.STATE_ENGAGE
var AI_class = Global.AI_CLASS_LIST.CLASS_NONE

const INPUT_LIST = {
	UI_UP    = "ui_up",
	UI_DOWN  = "ui_down",
	UI_LEFT  = "ui_left",
	UI_RIGHT = "ui_right",
	UI_PICK  = "ui_pick",
	UI_SHOOT = "ui_shoot",
	UI_SKIP  = "ui_skip",
	UI_SPACE = "ui_space",
	UI_READ = "ui_read",
	UI_1 = "ui_1",
	UI_2 = "ui_2",
	UI_3 = "ui_3",
	UI_4 = "ui_4",
	UI_5 = "ui_5",
	UI_6 = "ui_6"
}

var turn_count:int
var border_check:bool = true
var action_throw_item

var PLAYER_ACTION_SHOOT = false
var PLAYER_ACTION_THROW = false
var PLAYER_ACTION_INPUT = false
var PLAYER_ACTION_TEXT = false

# SOUNDS
#---------------------------------------------------------------------------------------
var sound_on_move = Sound.sfx_move
var sound_on_hit = Sound.sfx_hit_0
var sound_on_melee = Sound.sfx_punch_0
var sound_on_death = Sound.sfx_death_1
var sound_on_noammo = Sound.sfx_noammo

# STATS
#---------------------------------------------------------------------------------------
var equiped_weapon
var stat_visibility:int = 7
const stat_visibility_max:int = 7
var stat_melee_dmg:int = 2
#var stat_ranged_dmg:int = 3
#var stat_weapon_range:int = 3

var stat_ammo:int = 12
const stat_ammo_max:int = 99
var stat_speed:int = 1
const stat_speed_max:int = 99
var stat_health:int = 10
const stat_health_max:int = 99

# READY
#---------------------------------------------------------------------------------------
func _physics_process(_delta):
#	if Global.GAME_STATE == Global.GAME_STATE_LIST.STATE_PLAYER_TURN:
#		_unhandled_input(Input)
	ui_update()

func _ready():
	Global.NODE_PLAYER = self
	tween_speed_move = 25
	
	#PREPARE CAMERA2D
	var map_limits = Global.LEVEL_LAYER_LOGIC.get_used_rect()
	var map_cellsize = Global.LEVEL_LAYER_LOGIC.cell_size

	NODE_CAMERA_2D.limit_left = ((map_limits.position.x) * map_cellsize.x)
	NODE_CAMERA_2D.limit_right = ((map_limits.end.x) * map_cellsize.x)
	NODE_CAMERA_2D.limit_top = ((map_limits.position.y) * map_cellsize.y)
	NODE_CAMERA_2D.limit_bottom = ((map_limits.end.y) * map_cellsize.y)
	
	#PREPARE STARTING ANIMATIONS
	NODE_ANIMATED_SPRITE.set_animation(ANIMATIONS.MELEE)
	NODE_ANIMATED_SPRITE.set_frame(rand_range(0,NODE_ANIMATED_SPRITE.get_sprite_frames().get_frame_count(ANIMATIONS.MELEE)))
	pass

func ui_update():
	Global.UI_AMMO.set_text(self.stat_ammo as String)
	Global.UI_HEALTH.set_text(self.stat_health as String)
	Global.UI_LEVEL.set_text(Global.LEVEL_COUNT as String)
	Global.UI_TURN.set_text(self.stat_speed as String)

func _unhandled_input(key):
#	if Global.GAME_STATE == Global.GAME_STATE_LIST.STATE_NONE:
#		return
	if NODE_TWEEN.is_active() == true:
		return
	for input in INPUT_LIST.values():
		if key.is_action_pressed(input):
			if Global.GAME_STATE == Global.GAME_STATE_LIST.STATE_PLAYER_TURN:
				# MELEE MODE
				if PLAYER_ACTION_INPUT == false && PLAYER_ACTION_SHOOT == false && PLAYER_ACTION_TEXT == false && PLAYER_ACTION_THROW == false:
					if input == INPUT_LIST.UI_UP:    action_collision_check(Vector2.UP)
					if input == INPUT_LIST.UI_DOWN:  action_collision_check(Vector2.DOWN)
					if input == INPUT_LIST.UI_LEFT:  action_collision_check(Vector2.LEFT)
					if input == INPUT_LIST.UI_RIGHT: action_collision_check(Vector2.RIGHT)
					if input == INPUT_LIST.UI_PICK:  action_interact(Vector2(0,0))
					if input == INPUT_LIST.UI_READ:  action_read(Vector2(0,0))
					if input == INPUT_LIST.UI_SKIP:  
#						action_textlog()
						turn_count = stat_speed
						check_turn()
#						print(Global.LEVEL_LAYER_LOGIC.util_get_free_fog_cells())
					if input == INPUT_LIST.UI_SPACE: action_targets_check_shoot()
					if input == INPUT_LIST.UI_1: action_use_item(1)
					if input == INPUT_LIST.UI_2: action_use_item(2)
					if input == INPUT_LIST.UI_3: action_use_item(3)
					if input == INPUT_LIST.UI_4: action_use_item(4)
					if input == INPUT_LIST.UI_5: action_use_item(5)
					if input == INPUT_LIST.UI_6: action_use_item(6)
#					if input == INPUT_LIST.UI_SPACE: 
#						Global.GAME_STATE = Global.GAME_STATE_LIST.STATE_PAUSE
#						Global.NODE_MAIN.level_select()
				# RANGED MODE
				elif PLAYER_ACTION_INPUT == false && PLAYER_ACTION_SHOOT == true && PLAYER_ACTION_TEXT == false && PLAYER_ACTION_THROW == false:
					if input == INPUT_LIST.UI_UP:    action_shoot(Vector2.UP,equiped_weapon.stat_shoot_count)
					if input == INPUT_LIST.UI_DOWN:  action_shoot(Vector2.DOWN,equiped_weapon.stat_shoot_count)
					if input == INPUT_LIST.UI_LEFT:  action_shoot(Vector2.LEFT,equiped_weapon.stat_shoot_count)
					if input == INPUT_LIST.UI_RIGHT: action_shoot(Vector2.RIGHT,equiped_weapon.stat_shoot_count)
					if input == INPUT_LIST.UI_SKIP:  
						turn_count = stat_speed
						check_turn()
					if input == INPUT_LIST.UI_SPACE: action_targets_disbale()
					
				# THROWING MODE
				elif PLAYER_ACTION_INPUT == false && PLAYER_ACTION_THROW == true && PLAYER_ACTION_SHOOT == false && PLAYER_ACTION_TEXT == false:
					if input == INPUT_LIST.UI_UP:    action_throw(Vector2.UP)
					if input == INPUT_LIST.UI_DOWN:  action_throw(Vector2.DOWN)
					if input == INPUT_LIST.UI_LEFT:  action_throw(Vector2.LEFT)
					if input == INPUT_LIST.UI_RIGHT: action_throw(Vector2.RIGHT)
					if input == INPUT_LIST.UI_SPACE: action_targets_disbale()
				
				# TEXT MODE
				elif PLAYER_ACTION_INPUT == false && PLAYER_ACTION_SHOOT == false && PLAYER_ACTION_TEXT == true && PLAYER_ACTION_THROW == false:
					if input == INPUT_LIST.UI_SPACE:
						Global.NODE_UI_TEXT.hide()
						PLAYER_ACTION_TEXT = false
						pass
					pass
				else:
					pass

func action_targets_check_shoot():
	PLAYER_ACTION_INPUT = true
	PLAYER_ACTION_SHOOT = false
	var ready_to_shoot:bool = false
	var visibility_level = Data.LEVEL_DATA[Global.LEVEL_COUNT].get("SETTINGS")["Visibility"]
	var directons = Global.DIRECTION_LIST
	
	# Return if player has no ammo
	if stat_ammo == 0:
		PLAYER_ACTION_SHOOT = false
		PLAYER_ACTION_INPUT = false
		spawn_text("out of ammo",self.position/grid_size,Color.white,0.0)
		Sound.sound_spawn(Global.NODE_SOUNDS,sound_on_noammo,self.position/grid_size)
		return
	
	# Add items as collider exceptions
	get_raycast_exceptions(NODE_RAYCAST_COLLIDE,Global.GROUPS.ITEM)
	
	# Check for mob targes in range
	for direction in directons:
		NODE_RAYCAST_COLLIDE.cast_to = ((direction*grid_size)*min(visibility_level,min(equiped_weapon.stat_range,stat_visibility)))
		NODE_RAYCAST_COLLIDE.force_raycast_update()
		if NODE_RAYCAST_COLLIDE.is_colliding() == true:
			var collider = NODE_RAYCAST_COLLIDE.get_collider()
			if collider.get_class() == "KinematicBody2D":
				collider.NODE_ANIMATED_SPRITE_TARGET.visible = true
				ready_to_shoot = true
				
	# Player OK to shoot
	if ready_to_shoot == true:
		NODE_ANIMATED_SPRITE.set_animation(ANIMATIONS.RANGED)
		PLAYER_ACTION_SHOOT = true
	
	# Player NOT OK to shoot
	elif ready_to_shoot == false:
		spawn_text("out of range",self.position/grid_size,Color.white,0.0)
		Sound.sound_spawn(Global.NODE_SOUNDS,sound_on_noammo,self.position/grid_size)
		
#	NODE_ANIMATED_SPRITE.set_animation(ANIMATIONS.RANGED)
	NODE_RAYCAST_COLLIDE.clear_exceptions()
	PLAYER_ACTION_INPUT = false
	pass

func action_targets_check_throw(stat_throwable_range):
	PLAYER_ACTION_INPUT = true
	PLAYER_ACTION_THROW = true
	var visibility_level = Data.LEVEL_DATA[Global.LEVEL_COUNT].get("SETTINGS")["Visibility"]
	var directons = Global.DIRECTION_LIST
	var ready_to_throw:bool = false
	
	# Add items as collider exceptions
	get_raycast_exceptions(NODE_RAYCAST_COLLIDE,Global.GROUPS.ITEM)
	
	# Check for mob targes in range
	for direction in directons:
		NODE_RAYCAST_COLLIDE.cast_to = ((direction*grid_size)*min(visibility_level,min(stat_throwable_range,stat_visibility)))
		NODE_RAYCAST_COLLIDE.force_raycast_update()
		if NODE_RAYCAST_COLLIDE.is_colliding() == true :
			var collider = NODE_RAYCAST_COLLIDE.get_collider()
			if collider.get_class() == "KinematicBody2D":
				collider.NODE_ANIMATED_SPRITE_TARGET.visible = true
				ready_to_throw = true
				
	# Player OK to throw
	if ready_to_throw == true:
		NODE_ANIMATED_SPRITE.set_animation(ANIMATIONS.THROW)
		NODE_RAYCAST_COLLIDE.clear_exceptions()
		PLAYER_ACTION_INPUT = false
		return true
		
	# Player NOT OK to throw
	if ready_to_throw == false:
		NODE_ANIMATED_SPRITE.set_animation(ANIMATIONS.MELEE)
		NODE_RAYCAST_COLLIDE.clear_exceptions()
		PLAYER_ACTION_THROW = false
		PLAYER_ACTION_INPUT = false
		return false
	pass

func action_targets_disbale():
	PLAYER_ACTION_INPUT = true
	get_tree().call_group("HOSTILE","disable_target")
	NODE_ANIMATED_SPRITE.set_animation(ANIMATIONS.MELEE)
	PLAYER_ACTION_SHOOT = false
	PLAYER_ACTION_THROW = false
	PLAYER_ACTION_INPUT = false
	pass

func action_collision_check(direction):
	PLAYER_ACTION_INPUT = true
	
	# Add items as collider exceptions
	get_raycast_exceptions(NODE_RAYCAST_COLLIDE,Global.GROUPS.ITEM)
	
	NODE_RAYCAST_COLLIDE.cast_to = (direction*grid_size)
	NODE_RAYCAST_COLLIDE.force_raycast_update()
	if NODE_RAYCAST_COLLIDE.is_colliding() == false:
		action_move(direction)
	if NODE_RAYCAST_COLLIDE.is_colliding() == true:
		var cellA = NODE_MAIN.position
		var cellB = NODE_MAIN.position + (direction * grid_size)
		var collider = NODE_RAYCAST_COLLIDE.get_collider()
		var collider_cell = Vector2(cellB.x/8,cellB.y/8)
		var collider_cell_id = Global.LEVEL_LAYER_LOGIC.get_cell(collider_cell.x,collider_cell.y)
		if collider.get_class() == "KinematicBody2D":
			if collider.is_in_group(Global.GROUPS.HOSTILE) == true: 
				action_attack(direction,collider)
			if collider.is_in_group(Global.GROUPS.QUEEN) == true:
				Global.GAME_STATE = Global.GAME_STATE_LIST.STATE_NONE
				PLAYER_ACTION_TEXT = true
				action_textlog()
				Global.GAME_STATE = Global.GAME_STATE_LIST.STATE_PLAYER_TURN
				
	NODE_RAYCAST_COLLIDE.clear_exceptions()
	PLAYER_ACTION_INPUT = false

func action_textlog():
	Global.NODE_UI_TEXT.show()
	Global.NODE_UI_TEXTLOG.text = "< random queen bee sounds >"
	Global.NODE_UI_TEXTLOG.show_text()
	pass

func action_use_item(slot_id:int):
	PLAYER_ACTION_INPUT = true
	if Global.NODE_UI_INVENTORY.get_child_count() >= slot_id:
		var slot = Global.NODE_UI_INVENTORY.get_child(slot_id-1)
		var slot_item_count = slot.get_child_count()
		# Check if slot has item
		if slot_item_count == 1:
			var item = slot.get_child(0)
			item.on_action_use()
	else: 
		pass
	PLAYER_ACTION_INPUT = false

func action_interact(direction):
	PLAYER_ACTION_INPUT = true
	
	NODE_RAYCAST_COLLIDE.cast_to = (direction)
	NODE_RAYCAST_COLLIDE.force_raycast_update()
	
	if NODE_RAYCAST_COLLIDE.is_colliding() == false:
		var cell_player = NODE_MAIN.position
		var cell = Global.LEVEL_LAYER_LOGIC.get_cellv(Vector2(cell_player.x/grid_size,cell_player.y/grid_size))
		if cell == Global.LEVEL_LAYER_LOGIC.TILESET_LOGIC.TILE_EXIT:
			Sound.sound_spawn(Global.NODE_SOUNDS,Sound.sfx_exit,self.position/grid_size)
			Global.GAME_STATE = Global.GAME_STATE_LIST.STATE_PAUSE
			Global.NODE_MAIN.level_select()
			return
		pass
	elif NODE_RAYCAST_COLLIDE.is_colliding() == true:
		var collider = NODE_RAYCAST_COLLIDE.get_collider()
		if collider.get_class() == "StaticBody2D":
			# Regular item
			if collider.is_in_group(Global.GROUPS.ITEM) == true and collider.is_in_group(Global.GROUPS.TEXTLOG) == false:
						collider.on_action_pickup()
						check_turn()
			# Textlog item
			if collider.is_in_group(Global.GROUPS.ITEM) == true and collider.is_in_group(Global.GROUPS.TEXTLOG) == true:
						collider.on_action_pickup()
	PLAYER_ACTION_INPUT = false

func action_read(direction):
	PLAYER_ACTION_INPUT = true
	NODE_RAYCAST_COLLIDE.cast_to = (direction)
	NODE_RAYCAST_COLLIDE.force_raycast_update()
	
	if NODE_RAYCAST_COLLIDE.is_colliding() == true:
		var collider = NODE_RAYCAST_COLLIDE.get_collider()
		if collider.get_class() == "StaticBody2D":
			# Regular item
			if collider.is_in_group(Global.GROUPS.ITEM) == true and collider.is_in_group(Global.GROUPS.TEXTLOG) == false:
						collider.on_action_read()
			# Textlog item
			if collider.is_in_group(Global.GROUPS.ITEM) == true and collider.is_in_group(Global.GROUPS.TEXTLOG) == true:
						collider.on_action_read()
	PLAYER_ACTION_INPUT = false
	pass

func action_move(direction):
	var cellA = NODE_MAIN.position
	var cellB = NODE_MAIN.position + (direction * grid_size)
	
	#ANIMATION FLIP CHECK
	if cellA - cellB == Vector2(-grid_size,0): animation_flip(false,false)
	if cellA - cellB == Vector2(grid_size,0): animation_flip(true,false)
	
	Sound.sound_spawn(Global.NODE_SOUNDS,sound_on_move,self.position/grid_size)
	NODE_MAIN.action_move_tween(cellA,cellB)
	yield(NODE_TWEEN,"tween_all_completed")
	Global.LEVEL_LAYER_LOGIC.fog_update()
	check_turn()

func action_attack(direction,collider):
	var cellA = NODE_MAIN.position
	var cellB = NODE_MAIN.position + (direction * grid_size)
	
	#ANIMATION FLIP CHECK
	if cellA - cellB == Vector2(-grid_size,0): animation_flip(false,false)
	if cellA - cellB == Vector2(grid_size,0): animation_flip(true,false)
	
	NODE_MAIN.z_index += 1
	Sound.sound_spawn(Global.NODE_SOUNDS,sound_on_melee,self.position/grid_size)
	NODE_MAIN.calculate_melee_damage(self,collider)
	NODE_MAIN.action_attack_tween(cellA,cellB)
	yield(NODE_TWEEN,"tween_all_completed")
	collider.AI_state = Global.AI_STATE_LIST.STATE_ENGAGE
	NODE_MAIN.z_index -= 1
	check_turn()

func action_shoot(direction,shoot_count):
	PLAYER_ACTION_INPUT = true
	PLAYER_ACTION_SHOOT = false
	var visibility_level = Data.LEVEL_DATA[Global.LEVEL_COUNT].get("SETTINGS")["Visibility"]
	var turn_used:bool = false
	
	for count in shoot_count:
		# Disable target animation
		get_tree().call_group("HOSTILE","disable_target")
		
		# Add items as collider exceptions
		get_raycast_exceptions(NODE_RAYCAST_COLLIDE,Global.GROUPS.ITEM)
		
		# Check for mob targes in range
		NODE_RAYCAST_COLLIDE.cast_to = ((direction*grid_size)*min(visibility_level,min(equiped_weapon.stat_range,stat_visibility)))
		NODE_RAYCAST_COLLIDE.force_raycast_update()
		if NODE_RAYCAST_COLLIDE.is_colliding() == true :
			var collider = NODE_RAYCAST_COLLIDE.get_collider()
			if collider.get_class() == "KinematicBody2D":
				if collider.is_in_group(Global.GROUPS.HOSTILE) == true && NODE_MAIN.stat_ammo > 0: 
					var cellA = NODE_MAIN.position
					var cellB = NODE_MAIN.position + (direction * grid_size)
					
					#ANIMATION FLIP CHECK
					if cellA - cellB == Vector2(-grid_size,0): animation_flip(false,false)
					if cellA - cellB == Vector2(grid_size,0): animation_flip(true,false)
					
					NODE_MAIN.z_index += 1
					NODE_MAIN.stat_ammo -= 1
					Sound.sound_spawn(Global.NODE_SOUNDS,equiped_weapon.sound_on_ranged,self.position/grid_size)
					NODE_MAIN.calculate_ranged_damage(self,collider,equiped_weapon.stat_ranged_dmg)
					action_shoot_tween(cellA,get_negative_vector(cellA,cellB))
					yield(self.NODE_TWEEN,"tween_all_completed")
					collider.AI_state = Global.AI_STATE_LIST.STATE_ENGAGE
					NODE_MAIN.z_index -= 1
					turn_used = true
		else: pass
	equiped_weapon.on_action_shoot()
	yield(self.get_idle_frame(),"completed")
	NODE_ANIMATED_SPRITE.set_animation(ANIMATIONS.MELEE)
	NODE_RAYCAST_COLLIDE.clear_exceptions()
	PLAYER_ACTION_INPUT = false
	if turn_used == true: 
		check_turn()

func action_throw(direction):
	PLAYER_ACTION_INPUT = true
	PLAYER_ACTION_THROW = false
	var visibility_level = Data.LEVEL_DATA[Global.LEVEL_COUNT].get("SETTINGS")["Visibility"]
	var turn_used:bool = false
	
	# Disable target animation
	get_tree().call_group("HOSTILE","disable_target")
	
	# Add items as collider exceptions
	get_raycast_exceptions(NODE_RAYCAST_COLLIDE,Global.GROUPS.ITEM)
	
	# Check for mob targes in range
	NODE_RAYCAST_COLLIDE.cast_to = ((direction*grid_size)*min(visibility_level,min(action_throw_item.stat_throwable_range,stat_visibility)))
	NODE_RAYCAST_COLLIDE.force_raycast_update()
	if NODE_RAYCAST_COLLIDE.is_colliding() == true :
		var collider = NODE_RAYCAST_COLLIDE.get_collider()
		if collider.get_class() == "KinematicBody2D":
			if collider.is_in_group(Global.GROUPS.HOSTILE) == true: 
				var cellA = NODE_MAIN.position
				var cellB = NODE_MAIN.position + (direction * grid_size)
				
				#ANIMATION FLIP CHECK
				if cellA - cellB == Vector2(-grid_size,0): animation_flip(false,false)
				if cellA - cellB == Vector2(grid_size,0): animation_flip(true,false)
				
				NODE_MAIN.z_index += 1
				Sound.sound_spawn(Global.NODE_SOUNDS,action_throw_item.sound_on_throw,self.position/grid_size)
				NODE_MAIN.calculate_other_damage(action_throw_item.stat_dmg,collider)
				action_shoot_tween(cellA,get_negative_vector(cellA,cellB))
				yield(self.NODE_TWEEN,"tween_all_completed")
				action_throw_item.on_action_throw()
				action_throw_item = null
				collider.AI_state = Global.AI_STATE_LIST.STATE_ENGAGE
				NODE_MAIN.z_index -= 1
				turn_used = true
	else: pass
	NODE_ANIMATED_SPRITE.set_animation(ANIMATIONS.MELEE)
	NODE_RAYCAST_COLLIDE.clear_exceptions()
	PLAYER_ACTION_INPUT = false
	if turn_used == true: 
		check_turn()

func raycast_cast_to(node_name,cell_start,cell_finish):
	var cell_cast_to = Vector2(((cell_finish.x-cell_start.x)*grid_size),((cell_finish.y-cell_start.y)*grid_size))
	node_name.cast_to = Vector2(cell_cast_to.x,cell_cast_to.y)
	node_name.force_raycast_update()

func check_turn():
	# Disable target animation
	get_tree().call_group("HOSTILE","disable_target")
	NODE_ANIMATED_SPRITE.set_animation(ANIMATIONS.MELEE)
	PLAYER_ACTION_SHOOT = false
	yield(self.get_idle_frame(),"completed")
	
	# Check player turn count
	turn_count += 1
	if turn_count >= stat_speed: 
		Global.game_state_manager(Global.GAME_STATE_LIST.STATE_MOB_TURN)
	elif turn_count != stat_speed: 
		pass

func player_to_default():
	Global.NODE_UI_INVENTORY.clear_inventory()
	self.equiped_weapon = Data.pistol.instance()
#	self.equiped_weapon = Data.shotgun.instance()
#	self.equiped_weapon = Data.assault_rifle.instance()
	self.equiped_weapon.weapon_replace_in_inventory(equiped_weapon)
	self.NODE_ANIMATED_SPRITE.visible = true
	self.stat_health = 10
	self.stat_ammo = 12
	self.stat_speed = 1
	pass
	
func get_negative_vector(origin_vector, destination_vector):
	var negative_vector = (destination_vector - origin_vector).tangent().tangent() + origin_vector
	return Vector2(negative_vector.x,negative_vector.y)

func get_idle_frame():
	yield(get_tree(),"idle_frame")
