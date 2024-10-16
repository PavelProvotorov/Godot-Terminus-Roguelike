extends StaticBody2D
class_name Item2D

onready var NODE_SPRITE = $Sprite
onready var NODE_NAME = $Name
onready var grid_size = Global.grid_size
onready var item_name:String
onready var item_parent = Global.LEVEL_LAYER_LOGIC
onready var ammo_count:int
onready var item_last_target
onready var item_throw_position
onready var item_text = null

# READY
#---------------------------------------------------------------------------------------
func _ready():
	pass
	
func item_remove(parent):
	parent.remove_child(self)
	pass

func item_remove_from_inventory(parent):
	Global.score_items += 1
	parent.remove_child(self)
	parent.queue_free()
	pass

func item_add_to_inventory(item):
	if Global.NODE_UI_INVENTORY.get_child_count() < Global.NODE_UI_INVENTORY.item_slots_max:
		# ADD NEW ITEM SLOT
		var item_slot_data = load("res://Scenes/ItemSlot.tscn")
		var item_slot_instance = item_slot_data.instance()
		Global.NODE_UI_INVENTORY.add_child(item_slot_instance)
		
		# ADD ITEM TO SLOT
		item.item_parent = item_slot_instance
		item.position = Vector2(0,-1)
		Global.LEVEL_LAYER_LOGIC.remove_child(item)
		item_slot_instance.add_child(item)
		
	elif Global.NODE_UI_INVENTORY.get_child_count() == Global.NODE_UI_INVENTORY.item_slots_max:
		var item_to_drop = Global.NODE_UI_INVENTORY.get_child(0)
		item_to_drop = item_to_drop.get_child(0)
		
		#DROP FIRST ITEM IN INVENTORY
		item_to_drop.position = item.position
		item_to_drop.item_parent.remove_child(item_to_drop)
		Global.NODE_UI_INVENTORY.remove_child(item_to_drop.item_parent)
		item_to_drop.item_parent.queue_free()
		Global.LEVEL_LAYER_LOGIC.add_child(item_to_drop)
		
		# ADD NEW ITEM SLOT
		var item_slot_data = load("res://Scenes/ItemSlot.tscn")
		var item_slot_instance = item_slot_data.instance()
		Global.NODE_UI_INVENTORY.add_child(item_slot_instance)
		
		# ADD ITEM TO SLOT
		item.item_parent = item_slot_instance
		item.position = Vector2(0,-1)
		Global.LEVEL_LAYER_LOGIC.remove_child(item)
		item_slot_instance.add_child(item)
		pass
	else: 
		pass

func item_prepare_text():
	var text_list = Data.TEXT_DATA.values()
	var text = text_list[randi() % text_list.size()]
	return text

func item_display_text(item,text):
	Global.NODE_PLAYER.PLAYER_ACTION_TEXT = true
	Global.NODE_UI_TEXT.show()
	Global.NODE_UI_TEXTLOG.text = text
	Global.NODE_UI_TEXTLOG.show_text()
	pass

func weapon_add_to_inventory(item,player_position):
	var weapon_slot
	var weapon_slot_child
	if Global.NODE_PLAYER.equiped_weapon != null:
		weapon_slot = Global.NODE_UI_WEAPON.get_child(0)
		weapon_slot_child = weapon_slot.get_child(0)
		
		# DROP OLD WEAPON FROM SLOT
		weapon_slot.remove_child(weapon_slot_child)
		Global.LEVEL_LAYER_LOGIC.add_child(weapon_slot_child)
		weapon_slot_child.position = player_position
		
		# ADD NEW WEAPON TO SLOT
		item.item_parent = weapon_slot
		item.position = Vector2(1,-2)
		Global.LEVEL_LAYER_LOGIC.remove_child(item)
		weapon_slot.add_child(item)
		
		# ASSIGN WEAPON TO PLAYER
		Global.NODE_PLAYER.equiped_weapon = item
		
	elif Global.NODE_PLAYER.equiped_weapon == null:
		weapon_slot = Global.NODE_UI_WEAPON.get_child(0)
		# ADD NEW WEAPON TO SLOT
		item.item_parent = weapon_slot
		item.position = Vector2(1,-2)
		Global.LEVEL_LAYER_LOGIC.remove_child(item)
		weapon_slot.add_child(item)
		
		# ASSIGN WEAPON TO PLAYER
		Global.NODE_PLAYER.equiped_weapon = item

	else:
		pass

func weapon_replace_in_inventory(item):
	var weapon_slot = Global.NODE_UI_WEAPON.get_child(0)
	var weapon_slot_child
	
	if weapon_slot.get_child_count() == 1:
		# DELETE OLD WEAPON FROM SLOT
		weapon_slot_child = weapon_slot.get_child(0)
		weapon_slot.remove_child(weapon_slot_child)
		pass
	elif weapon_slot.get_child_count() == 0:
		pass
		
	# ADD NEW WEAPON TO SLOT
	item.item_parent = weapon_slot
	item.position = Vector2(1,-2)
	weapon_slot.add_child(item)
	
	# ASSIGN WEAPON TO PLAYER
	Global.NODE_PLAYER.equiped_weapon = item
	
	# CLEAR OUT STATS
	item.ammo_count = 0

func item_action_add_ammo(count,item):
	if count == 0: return
	Global.NODE_PLAYER.stat_ammo += count
	if Global.NODE_PLAYER.stat_ammo >= Global.NODE_PLAYER.stat_ammo_max: Global.NODE_PLAYER.stat_ammo = Global.NODE_PLAYER.stat_ammo_max
	if Global.NODE_PLAYER.stat_ammo <= Global.NODE_PLAYER.stat_ammo_max: pass
	item.ammo_count = 0
#	Global.NODE_PLAYER.spawn_text(count,Global.NODE_PLAYER.position/grid_size,Color.gold,0.0)
#	Sound.sound_spawn(Global.NODE_SOUNDS,Sound.sfx_pickup,self.position/grid_size)

func weapon_calculate_final_damage(distance):
	var final_damage:int = 0
	return final_damage

func util_chance(percentage):
	randomize()
	if percentage == 0:
		return false
	elif randi() % 100 <= percentage:  
		return true
	else:                     
		return false

func on_action_read():
	if item_text != null:
		item_display_text(self,item_text)
	else:
		pass

func on_action_shoot():
	pass

func on_action_tick():
	pass

func on_action_use():
	pass

func get_idle_frame():
	yield(get_tree(),"idle_frame")
