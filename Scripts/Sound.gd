extends Node

onready var sfx_shield_enable = preload("res://Sounds/sfx_shield_enable.ogg")
onready var sfx_shield_disable = preload("res://Sounds/sfx_shield_disable.ogg")
onready var sfx_type = preload("res://Sounds/sfx_type.ogg")
onready var sfx_blink = preload("res://Sounds/sfx_blink.ogg")
onready var sfx_exit = preload("res://Sounds/sfx_exit.ogg")
onready var sfx_level_1 = preload("res://Sounds/sfx_level_1.ogg")
onready var sfx_level_2 = preload("res://Sounds/sfx_level_2.ogg")
onready var sfx_level_3 = preload("res://Sounds/sfx_level_3.ogg")
onready var sfx_level_5 = preload("res://Sounds/sfx_level_5.ogg")
onready var sfx_pickup = preload("res://Sounds/sfx_pickup.ogg")
onready var sfx_move = preload("res://Sounds/sfx_move.ogg")
onready var sfx_spit = preload("res://Sounds/sfx_spit.ogg")
onready var sfx_shotgun_0= preload("res://Sounds/sfx_shotgun_0.ogg")
onready var sfx_pistol_0 = preload("res://Sounds/sfx_pistol_0.ogg")
onready var sfx_revolver_0 = preload("res://Sounds/sfx_revolver_0.ogg")
onready var sfx_assault_0 = preload("res://Sounds/sfx_assault_0.ogg")
onready var sfx_sawnoff_0 = preload("res://Sounds/sfx_sawnoff_0.ogg")
onready var sfx_rifle_0 = preload("res://Sounds/sfx_rifle_0.ogg")
onready var sfx_final_cluster = preload("res://Sounds/sfx_final_cluster.ogg")
onready var sfx_hit_0 = preload("res://Sounds/sfx_hit_0.ogg")
onready var sfx_punch_0 = preload("res://Sounds/sfx_punch_0.ogg")
onready var sfx_noammo = preload("res://Sounds/sfx_noammo.ogg")
onready var sfx_explosion_0 = preload("res://Sounds/sfx_explosion_0.ogg")
onready var sfx_teleport = preload("res://Sounds/sfx_teleport.ogg")
onready var sfx_menu_move = preload("res://Sounds/sfx_menu_move.ogg")
onready var sfx_mob_appear = preload("res://Sounds/sfx_mob_appear.ogg")

# SIGNALS
#---------------------------------------------------------------------------------------
signal on_sound_finished

#---------------------------------------------------------------------------------------
func play_sound(entity,sound_name):
	entity.NODE_SOUND.stream = sound_name
	entity.NODE_SOUND.play()
	emit_signal("on_sound_finished")
	pass

func play_sound_deferred(entity,sound_name):
	entity.NODE_SOUND.stream = sound_name
	entity.NODE_SOUND.play()
	emit_signal("on_sound_finished")
	pass

func play_sound_death(entity,sound_name):
	entity.NODE_SOUND_DEATH.stream = sound_name
	entity.NODE_SOUND_DEATH.play()
	pass

func sound_spawn(sound_parent,sound_name,sound_position:Vector2):
	var sound_data = load("res://Scenes/SoundPlay.tscn")
	var sound_instance = sound_data.instance()
	sound_parent.add_child(sound_instance)
	sound_instance.sound_parent = sound_parent
	sound_instance.set_global_position(Vector2((sound_position.x)*Global.grid_size,(sound_position.y)*Global.grid_size))
	sound_instance.stream = sound_name
	sound_instance.play()

func music_spawn(sound_parent,sound_name):
	var previous_music
	if Global.LEVEL_COUNT > 0:
		previous_music = Data.LEVEL_DATA[Global.LEVEL_COUNT-1].get("SETTINGS")["Music"]
		pass
	var next_music = Data.LEVEL_DATA[Global.LEVEL_COUNT].get("SETTINGS")["Music"]
	if previous_music != next_music:
		if Global.CURRENT_MUSIC != null:
			Global.CURRENT_MUSIC.music_fade_out()
		var sound_data = load("res://Scenes/MusicPlay.tscn")
		var sound_instance = sound_data.instance()
		sound_parent.add_child(sound_instance)
		sound_instance.sound_parent = sound_parent
		sound_instance.stream = Sound.get(sound_name)
		sound_instance.play()
	else:
		pass
	
func get_idle_frame():
	yield(get_tree(),"idle_frame")
