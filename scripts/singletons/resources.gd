extends Node

onready var text_label = preload("res://scenes/TextLabel.tscn")
onready var scene_description = preload("res://scenes/Description.tscn")
onready var debug_label = preload("res://scenes/DebugLabel.tscn")
onready var debug_vermin = preload("res://scenes/mobs/Vermin.tscn")
onready var debug_colony = preload("res://scenes/mobs/Colony.tscn")
onready var debug_maggot = preload("res://scenes/mobs/Maggot.tscn")
onready var debug_creep = preload("res://scenes/mobs/Creep.tscn")
onready var debug_grunt = preload("res://scenes/mobs/Grunt.tscn")
onready var debug_goo = preload("res://scenes/mobs/Goo.tscn")
onready var debug_ally = preload("res://scenes/mobs/Ally.tscn")
onready var debug_cat_maison = preload("res://scenes/mobs/CatMaison.tscn")
onready var debug_cat_sorik= preload("res://scenes/mobs/CatSorik.tscn")
onready var debug_cat_luxor= preload("res://scenes/mobs/CatLuxor.tscn")
onready var player = load("res://scenes/mobs/Player.tscn")

onready var weapon_pistol = load("res://scenes/weapons/Pistol.tscn")
onready var weapon_revolver = load("res://scenes/weapons/Revolver.tscn")
onready var weapon_sawn_off = load("res://scenes/weapons/SawnOff.tscn")
onready var weapon_shotgun = load("res://scenes/weapons/Shotgun.tscn")
onready var weapon_tactical_shotgun = load("res://scenes/weapons/TacticalShotgun.tscn")
onready var weapon_hunting_rifle = load("res://scenes/weapons/HuntingRifle.tscn")
onready var weapon_assault_rifle = load("res://scenes/weapons/AssaultRifle.tscn")
onready var weapon_sniper_rifle = load("res://scenes/weapons/SniperRifle.tscn")
onready var weapon_submachine = load("res://scenes/weapons/Submachine.tscn")
onready var weapon_railgun = load("res://scenes/weapons/Railgun.tscn")

onready var weapon_slicer = load("res://scenes/weapons/Slicer.tscn")
onready var weapon_hammer = load("res://scenes/weapons/Hammer.tscn")
onready var weapon_pike = load("res://scenes/weapons/Pike.tscn")
onready var weapon_tactical_knife = load("res://scenes/weapons/TacticalKnife.tscn")

onready var level_scene = load("res://scenes/levels/Level.tscn")
onready var factory_scene = load("res://scenes/levels/Factory.tscn")
onready var location_2 = load("res://scenes/levels/Location2.tscn")
onready var location_3 = load("res://scenes/levels/Location3.tscn")
onready var location_4 = load("res://scenes/levels/Location4.tscn")
onready var location_5 = load("res://scenes/levels/Location5.tscn")

onready var icon_none = load("res://assets/icons/icon_none.png")
onready var icon_strength = load("res://assets/icons/icon_strength.png")
onready var icon_speed = load("res://assets/icons/icon_speed.png")
onready var icon_poison = load("res://assets/icons/icon_poison.png")
onready var icon_shield = load("res://assets/icons/icon_shield.png")
onready var icon_regeneration = load("res://assets/icons/icon_regeneration.png")
onready var icon_blindness = load("res://assets/icons/icon_blindness.png")
onready var icon_vision = load("res://assets/icons/icon_vision.png")
onready var icon_bleed = load("res://assets/icons/icon_bleed.png")
onready var icon_stun = load("res://assets/icons/icon_stun.png")

onready var customise_scene = load("res://scenes/ui/Customise.tscn")
onready var menu_scene = load("res://scenes/ui/Menu.tscn")
onready var buff_card = load("res://scenes/ui/BuffCard.tscn")

onready var obj_factory = load("res://scenes/furniture/ObjectFactory.tscn")
onready var obj_cistern = load("res://scenes/furniture/ObjectCistern.tscn")
onready var obj_conveyor = load("res://scenes/furniture/Conveyor.tscn")
onready var obj_ventilation = load("res://scenes/furniture/Ventilation.tscn")
onready var obj_power_cell = load("res://scenes/furniture/PowerCell.tscn")

const sfx_2D = preload("res://scenes/Sfx2D.tscn")
const sfx = preload("res://scenes/Sfx.tscn")

const SOUNDS = {
	move = preload("res://sfx/move.ogg"),
	pickup_0 = preload("res://sfx/pickup_0.ogg"),
	hit_0 = preload("res://sfx/hit_0.ogg"),
	shot_0 = preload("res://sfx/shot_0.ogg"),
	shot_1 = preload("res://sfx/shot_1.ogg"),
	shot_shotgun = preload("res://sfx/shot_shotgun.ogg"),
	shot_hunting_rifle = preload("res://sfx/shot_hunting_rifle.ogg"),
	explosion_0 = preload("res://sfx/explosion_0.ogg"),
	shield_enable = preload("res://sfx/shield_enable.ogg"),
	shield_disable = preload("res://sfx/shield_disable.ogg"),
	visor_enable = preload("res://sfx/visor_enable.ogg"),
	visor_disable = preload("res://sfx/visor_disable.ogg"),
	teleport = preload("res://sfx/teleport.ogg"),
	fail = preload("res://sfx/fail.ogg"),
	descend = preload("res://sfx/descend.ogg"),
	switch = preload("res://sfx/switch.ogg"),
	drop = preload("res://sfx/drop.ogg"),
	typing = preload("res://sfx/typing.ogg"),
	appear = preload("res://sfx/appear.ogg"),
	open = preload("res://sfx/open.ogg"),
	menu_move = preload("res://sfx/menu_move.ogg"),
}

const head_spritesheet: Dictionary = {
	0: preload("res://assets/composites/head/player_head_0.png"),
	1: preload("res://assets/composites/head/player_head_1.png"),
	2: preload("res://assets/composites/head/player_head_2.png"),
	3: preload("res://assets/composites/head/player_head_3.png"),
	4: preload("res://assets/composites/head/player_head_4.png")
}

const body_spritesheet: Dictionary = {
	0: preload("res://assets/composites/body/player_body_0.png"),
	1: preload("res://assets/composites/body/player_body_1.png"),
	2: preload("res://assets/composites/body/player_body_2.png"),
	3: preload("res://assets/composites/body/player_body_3.png")
}

const default_enemies: Dictionary = {
	"Grunt": 100,
	"Bloater": 100,
	"Colony": 100,
	"MindFlayer": 0,
	"Hydra": 0,
	"Abomination": 0,
	"Parasite": 0,
	"Insect": 0,
	"Lurker": 0,
	"Behemoth": 0,
	"Horror": 0,
	"Wart": 0,
	"Infestinator": 0,
	"Creep": 0,
	"Sludge": 0,
	"Infected": 0,
	"Stalker": 0,
	"Scout": 0,
	"Templar": 0,
	"Zealot": 0,
}

const default_weapons: Dictionary = {
	"AssaultRifle": 100,
	"HuntingRifle": 100,
	"Pistol": 100,
	"Revolver": 100,
	"SawnOff": 100,
	"Shotgun": 100,
	"SniperRifle": 100,
	"Submachine": 100,
	"TacticalShotgun": 100,
	"RailGun": 100,
	"TacticalKnife": 0,
	"Slicer": 100,
	"Pike": 100,
	"Hammer": 100,
}

const default_items: Dictionary = {
#	"Bandage": 10,
#	"Ammo": 50,
#	"Visor": 5,
#	"Grenade": 5,
#	"FragGrenade": 5,
#	"Medkit": 10,
#	"Teleporter": 5,
#	"ShieldGenerator": 5,
#	"Adrenalin": 5,
	"Steroids": 5,
#	"ThunderFlash": 5,
}

onready var level_configuration: Dictionary = {
	0: {
		'scene': factory_scene,
		'enemies': {
			"GuardBot": 15,
			"Grunt": 100,
			"Bloater": 80,
			"Colony": 50,
		},
		'items': default_items,
		'weapons': default_weapons,
	},
	1: {
		'scene': location_2,
		'enemies': {
			"Insect": 100,
			"Parasite": 50,
			"Abomination": 25,
			"Lurker": 25,
		},
		'items': default_items,
		'weapons': default_weapons,
	},
	2: {
		'scene': location_3,
		'enemies': {
			"Hydra": 50,
			"Infestinator": 25,
			"Behemoth": 50,
			"Wart": 100,
		},
		'items': default_items,
		'weapons': default_weapons,
	},
	3: {
		'scene': location_4,
		'enemies': {
			"MindFlayer": 50,
			"Horror": 50,
			"Sludge": 25,
			"Infected": 100,
		},
		'items': default_items,
		'weapons': default_weapons,
	},
	4: {
		'scene': location_5,
		'enemies': {
			"Stalker": 25,
			"Scout": 50,
			"Templar": 80,
			"Zealot": 100,
		},
		'items': default_items,
		'weapons': default_weapons,
	}
}
