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
onready var weapon_tactical_knife = load("res://scenes/weapons/TacticalKnife.tscn")

onready var level_scene = load("res://scenes/levels/Level.tscn")
onready var factory_scene = load("res://scenes/levels/Factory.tscn")
onready var location_2 = load("res://scenes/levels/Location2.tscn")
onready var location_3 = load("res://scenes/levels/Location3.tscn")
onready var location_4 = load("res://scenes/levels/Location4.tscn")
onready var location_5 = load("res://scenes/levels/Location5.tscn")

onready var customise_scene = load("res://scenes/ui/Customise.tscn")
onready var menu_scene = load("res://scenes/ui/Menu.tscn")

const head_spritesheet: Dictionary = {
	0: preload("res://assets/composites/head/player_head_0.png"),
	1: preload("res://assets/composites/head/player_head_1.png"),
	2: preload("res://assets/composites/head/player_head_2.png")
}

const body_spritesheet: Dictionary = {
	0: preload("res://assets/composites/body/player_body_0.png"),
	1: preload("res://assets/composites/body/player_body_1.png")
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
}

const default_items: Dictionary = {
	"Bandage": 5,
	"Ammo": 50,
	"Grenade": 5,
	"FragGrenade": 5,
	"Medkit": 5,
	"Teleporter": 5,
	"ShieldGenerator": 5,
	"Adrenalin": 5,
	"Steroids": 5
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
