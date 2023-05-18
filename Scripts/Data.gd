extends Node

onready var shotgun = preload("res://Items/Shotgun.tscn")
onready var tactical_shotgun = preload("res://Items/TacticalShotgun.tscn")
onready var hunting_rifle = preload("res://Items/HuntingRifle.tscn")
onready var assault_rifle = preload("res://Items/AssaultRifle.tscn")
onready var revolver = preload("res://Items/Revolver.tscn")
onready var sawnoff = preload("res://Items/SawnOff.tscn")
onready var pistol = preload("res://Items/Pistol.tscn")

onready var goo = preload("res://Mobs/Goo.tscn")

# TEXT
#---------------------------------------------------------------------------------------
onready var TEXT_DATA = {
	"text_0": "this is text 0",
	"text_1": "this is text 1",
	"text_2": "this is text 2"
}

# DESCRIPTION
#---------------------------------------------------------------------------------------
onready var DESCRIPTION_DATA = {
	"item_sawn_off": "A shotgun with a shorter gun barrel has increased power, but that also reduces its range drastically.",
	"item_shotgun": "This is a trustworthy shotgun, used commonly among the guards and cleanup forces, ideal for enclosed spaces.",
	"item_assault_rifle": "The weapon of choice for space mercenaries and soldiers, can quickly dispatch both crowds of enemies and your ammo reserves.",
	"item_submachine_gun": "A compact and reliable weapon designed for space combat, with an advantage of a high fire rate.",
	"item_hunting_rifle": "The perfect weapon for spacefaring adventurers, that can take down even the most elusive and dangerous targets.",
	"item_sniper_rifle": "The sniper rifle is the ultimate weapon for any marksman looking to take down their targets from a safe distance.",
	"item_tactical_shotgun": "A reliable and versatile military grade close-quarters weapon, perfect for taking down enemies while keeping a safe distance.",
	"item_pistol": "A sleek and stylish weapon fine-tuned for optimal performance in any situation. Its compact size also makes it easy to maneuver with.",
	"item_revolver": "",
	"item_bigdan_001": "",
	"item_emp_grenade": "The EMP grenade can emit a blinding flash of light and a loud noise, slowing and stunning anyone caught in its blast radius.",
	"item_frag_grenade": "The fragmentation grenade can create a devastating explosion that sends shrapnel flying in all directions, tearing through armor and flesh with ease.",
	"item_grenade": "An ideal utility weapon, for engaging in intense space combat or conducting devastating strikes against enemy targets",
	"item_medkit": "The essential tool for those looking to stay healthy and safe on their journeys. This compact and durable medkit contains everything you need to treat minor injuries and ailments.",
	"item_adrenalin": "With its advanced formula, this drug can provide the user with a temporary burst of speed and energy, allowing them to perform at their best in even the most demanding situations.",
	"item_steroids": "This performance-enhancing drug can provide users with a temporary boost to their strength, making them a fearsome unit in melee combat.",
	"item_teleporter": "With its advanced technology, this device can teleport the user to a random destination within range. Great to have for safety measures.",
	"item_ammo_pack": "This durable and lightweight ammo pack contains everything you need to reload your weapons on the go, from energy cells and plasma cartridges to high-caliber bullets and explosive rounds.",
	"item_shield_generator": "The shield generator can create a powerful force field around the user, providing a barrier against incoming attacks for a short period of time."
}

# LEVELS
#---------------------------------------------------------------------------------------
onready var LEVEL_DATA = {
	0: {
		"SETTINGS": {
			"IsRandom": true,
			"MinMobCount": 3,
			"MaxMobCount": 5,
			"Visibility": 7,
			"Music": "sfx_level_0"
		},
		"LEVELS": {
			"Level_0": 100
		},
		"MOBS": {
			"Grunt": 100
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"ShieldGenerator": 10,
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"EMPGrenade": 10,
				"FragGrenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 50,
				"Revolver": 50,
				"SawnOff": 50,
				"Shotgun": 50,
				"SubmachineGun": 50,
				"HuntingRifle": 50,
				"AssaultRifle": 50,
				"TacticalShotgun": 50,
				"SniperRifle": 50
			},
			"OTHER": {
#				"BigDan001": 100
			}
		},
	},
	1: {
		"SETTINGS": {
			"IsRandom": true,
			"MinMobCount": 3,
			"MaxMobCount": 5,
			"Visibility": 7,
			"Music": "sfx_level_1"
		},
		"LEVELS": {
			"Level_1": 100
		},
		"MOBS": {
			"Grunt": 100,
			"Maggot": 25,
			"Colony": 0,
			"Bloater": 0
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"ShieldGenerator": 10,
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"EMPGrenade": 10,
				"FragGrenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 50,
				"Revolver": 0,
				"SawnOff": 50,
				"Shotgun": 50,
				"SubmachineGun": 50,
				"HuntingRifle": 5,
				"AssaultRifle": 0,
				"TacticalShotgun": 0,
				"SniperRifle": 0
			},
			"OTHER": {
#				"BigDan001": 100
			}
		},
	},
	2: {
		"SETTINGS": {
			"IsRandom": true,
			"MinMobCount": 3,
			"MaxMobCount": 5,
			"Visibility": 7,
			"Music": "sfx_level_1"
		},
		"LEVELS": {
			"Level_1": 100
		},
		"MOBS": {
			"Grunt": 75,
			"Maggot": 50,
			"Colony": 50,
			"Bloater": 25
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"ShieldGenerator": 10,
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"EMPGrenade": 10,
				"FragGrenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 25,
				"Revolver": 0,
				"SawnOff": 25,
				"Shotgun": 45,
				"SubmachineGun": 45,
				"HuntingRifle": 25,
				"AssaultRifle": 0,
				"TacticalShotgun": 0,
				"SniperRifle": 0
			},
			"OTHER": {
#				"BigDan001": 100
			}
		},
	},
	3: {
		"SETTINGS": {
			"IsRandom": true,
			"MinMobCount": 4,
			"MaxMobCount": 6,
			"Visibility": 7,
			"Music": "sfx_level_1"
		},
		"LEVELS": {
			"Level_1": 100
		},
		"MOBS": {
			"Grunt": 50,
			"Maggot": 100,
			"Colony": 75,
			"Bloater": 25
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"ShieldGenerator": 10,
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"EMPGrenade": 10,
				"FragGrenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 10,
				"Revolver": 0,
				"SawnOff": 10,
				"Shotgun": 40,
				"SubmachineGun": 40,
				"HuntingRifle": 40,
				"AssaultRifle": 0,
				"TacticalShotgun": 0,
				"SniperRifle": 0
			},
			"OTHER": {
#				"BigDan001": 100
			}
		},
	},
	4: {
		"SETTINGS": {
			"IsRandom": true,
			"MinMobCount": 4,
			"MaxMobCount": 6,
			"Visibility": 7,
			"Music": "sfx_level_1"
		},
		"LEVELS": {
			"Level_1": 100
		},
		"MOBS": {
			"Grunt": 25,
			"Maggot": 100,
			"Colony": 75,
			"Bloater": 50
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"ShieldGenerator": 10,
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"EMPGrenade": 10,
				"FragGrenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 5,
				"Revolver": 0,
				"SawnOff": 0,
				"Shotgun": 40,
				"SubmachineGun": 40,
				"HuntingRifle": 40,
				"AssaultRifle": 0,
				"TacticalShotgun": 0,
				"SniperRifle": 0
			},
			"OTHER": {
#				"BigDan001": 100
			}
		},
	},
	5: {
		"SETTINGS": {
			"IsRandom": true,
			"MinMobCount": 5,
			"MaxMobCount": 7,
			"Visibility": 7,
			"Music": "sfx_level_1"
		},
		"LEVELS": {
			"Level_1": 100
		},
		"MOBS": {
			"Grunt": 25,
			"Maggot": 100,
			"Colony": 75,
			"Bloater": 75
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"ShieldGenerator": 10,
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"EMPGrenade": 10,
				"FragGrenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"Revolver": 0,
				"SawnOff": 0,
				"Shotgun": 40,
				"SubmachineGun": 40,
				"HuntingRifle": 40,
				"AssaultRifle": 1,
				"TacticalShotgun": 1,
				"SniperRifle": 0
			},
			"OTHER": {
#				"BigDan001": 100
			}
		},
	},
	6: {
		"SETTINGS": {
			"IsRandom": true,
			"MinMobCount": 3,
			"MaxMobCount": 5,
			"Visibility": 6,
			"Music": "sfx_level_2"
		},
		"LEVELS": {
			"Level_2": 100
		},
		"MOBS": {
			"GruntInsect": 100,
			"Parasite": 25,
			"Abomination": 0,
			"Lurker": 0
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"ShieldGenerator": 10,
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"EMPGrenade": 10,
				"FragGrenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"Revolver": 0,
				"SawnOff": 0,
				"Shotgun": 35,
				"SubmachineGun": 35,
				"HuntingRifle": 35,
				"AssaultRifle": 5,
				"TacticalShotgun": 5,
				"SniperRifle": 0
			},
			"OTHER": {
#				"BigDan001": 100
			}
		},
	},
	7: {
		"SETTINGS": {
			"IsRandom": true,
			"MinMobCount": 3,
			"MaxMobCount": 5,
			"Visibility": 6,
			"Music": "sfx_level_2"
		},
		"LEVELS": {
			"Level_2": 100
		},
		"MOBS": {
			"GruntInsect": 100,
			"Parasite": 25,
			"Vermin": 25,
			"Abomination": 10,
			"Lurker": 5
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"ShieldGenerator": 10,
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"EMPGrenade": 10,
				"FragGrenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"Revolver": 0,
				"SawnOff": 0,
				"Shotgun": 30,
				"SubmachineGun": 30,
				"HuntingRifle": 30,
				"AssaultRifle": 8,
				"TacticalShotgun": 8,
				"SniperRifle": 0
			},
			"OTHER": {
#				"BigDan001": 100
			}
		},
	},
	8: {
		"SETTINGS": {
			"IsRandom": true,
			"MinMobCount": 4,
			"MaxMobCount": 6,
			"Visibility": 6,
			"Music": "sfx_level_2"
		},
		"LEVELS": {
			"Level_2": 100
		},
		"MOBS": {
			"GruntInsect": 75,
			"Parasite": 50,
			"Vermin": 50,
			"Abomination": 25,
			"Lurker": 10
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"ShieldGenerator": 10,
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"EMPGrenade": 10,
				"FragGrenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"Revolver": 0,
				"SawnOff": 0,
				"Shotgun": 25,
				"SubmachineGun": 25,
				"HuntingRifle": 25,
				"AssaultRifle": 10,
				"TacticalShotgun": 10,
				"SniperRifle": 0
			},
			"OTHER": {
#				"BigDan001": 100
			}
		},
	},
	9: {
		"SETTINGS": {
			"IsRandom": true,
			"MinMobCount": 4,
			"MaxMobCount": 6,
			"Visibility": 6,
			"Music": "sfx_level_2"
		},
		"LEVELS": {
			"Level_2": 100
		},
		"MOBS": {
			"GruntInsect": 50,
			"Parasite": 50,
			"Vermin": 75,
			"Abomination": 50,
			"Lurker": 15
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"ShieldGenerator": 10,
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"EMPGrenade": 10,
				"FragGrenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"Revolver": 0,
				"SawnOff": 0,
				"Shotgun": 15,
				"SubmachineGun": 15,
				"HuntingRifle": 15,
				"AssaultRifle": 10,
				"TacticalShotgun": 10,
				"SniperRifle": 0
			},
			"OTHER": {
#				"BigDan001": 100
			}
		},
	},
	10: {
		"SETTINGS": {
			"IsRandom": true,
			"MinMobCount": 5,
			"MaxMobCount": 7,
			"Visibility": 6,
			"Music": "sfx_level_2"
		},
		"LEVELS": {
			"Level_2": 100
		},
		"MOBS": {
			"GruntInsect": 25,
			"Parasite": 25,
			"Vermin": 100,
			"Abomination": 75,
			"Lurker": 25
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"ShieldGenerator": 10,
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"EMPGrenade": 10,
				"FragGrenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"Revolver": 0,
				"SawnOff": 0,
				"Shotgun": 15,
				"SubmachineGun": 15,
				"HuntingRifle": 15,
				"AssaultRifle": 15,
				"TacticalShotgun": 15,
				"SniperRifle": 1
			},
			"OTHER": {
#				"BigDan001": 100
			}
		},
	},
	11: {
		"SETTINGS": {
			"IsRandom": true,
			"MinMobCount": 3,
			"MaxMobCount": 5,
			"Visibility": 5,
			"Music": "sfx_level_2"
		},
		"LEVELS": {
			"Level_3": 100
		},
		"MOBS": {
			"Wart": 100,
			"Hydra": 50,
			"Behemoth": 0,
			"Infestinator": 0
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"ShieldGenerator": 10,
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"EMPGrenade": 10,
				"FragGrenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"Revolver": 5,
				"SawnOff": 0,
				"Shotgun": 10,
				"SubmachineGun": 10,
				"HuntingRifle": 10,
				"AssaultRifle": 25,
				"TacticalShotgun": 25,
				"SniperRifle": 1
			},
			"OTHER": {
#				"BigDan001": 100
			}
		},
	},
	12: {
		"SETTINGS": {
			"IsRandom": true,
			"MinMobCount": 3,
			"MaxMobCount": 5,
			"Visibility": 5,
			"Music": "sfx_level_2"
		},
		"LEVELS": {
			"Level_3": 100
		},
		"MOBS": {
			"Wart": 75,
			"Hydra": 75,
			"Behemoth": 25,
			"Infestinator": 0
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"ShieldGenerator": 10,
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"EMPGrenade": 10,
				"FragGrenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"Revolver": 10,
				"SawnOff": 0,
				"Shotgun": 10,
				"SubmachineGun": 10,
				"HuntingRifle": 10,
				"AssaultRifle": 35,
				"TacticalShotgun": 35,
				"SniperRifle": 1
			},
			"OTHER": {
#				"BigDan001": 100
			}
		},
	},
	13: {
		"SETTINGS": {
			"IsRandom": true,
			"MinMobCount": 4,
			"MaxMobCount": 6,
			"Visibility": 5,
			"Music": "sfx_level_2"
		},
		"LEVELS": {
			"Level_3": 100
		},
		"MOBS": {
			"Wart": 50,
			"Hydra": 75,
			"Behemoth": 50,
			"Infestinator": 25
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"ShieldGenerator": 10,
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"EMPGrenade": 10,
				"FragGrenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"Revolver": 15,
				"SawnOff": 0,
				"Shotgun": 10,
				"SubmachineGun": 10,
				"HuntingRifle": 10,
				"AssaultRifle": 50,
				"TacticalShotgun": 50,
				"SniperRifle": 1
			},
			"OTHER": {
#				"BigDan001": 100
			}
		},
	},
	14: {
		"SETTINGS": {
			"IsRandom": true,
			"MinMobCount": 4,
			"MaxMobCount": 6,
			"Visibility": 5,
			"Music": "sfx_level_2"
		},
		"LEVELS": {
			"Level_3": 100
		},
		"MOBS": {
			"Wart": 25,
			"Hydra": 75,
			"Behemoth": 100,
			"Infestinator": 50
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"ShieldGenerator": 10,
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"EMPGrenade": 10,
				"FragGrenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"Revolver": 25,
				"SawnOff": 0,
				"Shotgun": 5,
				"SubmachineGun": 5,
				"HuntingRifle": 5,
				"AssaultRifle": 75,
				"TacticalShotgun": 75,
				"SniperRifle": 1
			},
			"OTHER": {
#				"BigDan001": 100
			}
		},
	},
	15: {
		"SETTINGS": {
			"IsRandom": true,
			"MinMobCount": 5,
			"MaxMobCount": 7,
			"Visibility": 5,
			"Music": "sfx_level_2"
		},
		"LEVELS": {
			"Level_3": 100
		},
		"MOBS": {
			"Wart": 25,
			"Hydra": 100,
			"Behemoth": 100,
			"Infestinator": 75
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"ShieldGenerator": 10,
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"EMPGrenade": 10,
				"FragGrenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"Revolver": 50,
				"SawnOff": 0,
				"Shotgun": 5,
				"SubmachineGun": 5,
				"HuntingRifle": 5,
				"AssaultRifle": 75,
				"TacticalShotgun": 75,
				"SniperRifle": 5
			},
			"OTHER": {
#				"BigDan001": 100
			}
		},
	},
	16: {
		"SETTINGS": {
			"IsRandom": true,
			"MinMobCount": 3,
			"MaxMobCount": 5,
			"Visibility": 4,
			"Music": "sfx_level_3"
		},
		"LEVELS": {
			"Level_4": 100
		},
		"MOBS": {
			"GruntInfected": 100,
			"Goo": 50,
			"Horror": 0,
			"Sludge": 0,
			"MindFlayer": 0
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"ShieldGenerator": 10,
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"EMPGrenade": 10,
				"FragGrenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"Revolver": 15,
				"SawnOff": 0,
				"Shotgun": 0,
				"SubmachineGun": 0,
				"HuntingRifle": 0,
				"AssaultRifle": 75,
				"TacticalShotgun": 75,
				"SniperRifle": 10
			},
			"OTHER": {
#				"BigDan001": 100
			}
		},
	},
	17: {
		"SETTINGS": {
			"IsRandom": true,
			"MinMobCount": 3,
			"MaxMobCount": 5,
			"Visibility": 4,
			"Music": "sfx_level_3"
		},
		"LEVELS": {
			"Level_4": 100
		},
		"MOBS": {
			"GruntInfected": 75,
			"Goo": 25,
			"Horror": 25,
			"Sludge": 0,
			"MindFlayer": 5
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"ShieldGenerator": 10,
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"EMPGrenade": 10,
				"FragGrenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"Revolver": 10,
				"SawnOff": 0,
				"Shotgun": 0,
				"SubmachineGun": 0,
				"HuntingRifle": 0,
				"AssaultRifle": 75,
				"TacticalShotgun": 75,
				"SniperRifle": 10
			},
			"OTHER": {
#				"BigDan001": 100
			}
		},
	},
	18: {
		"SETTINGS": {
			"IsRandom": true,
			"MinMobCount": 4,
			"MaxMobCount": 6,
			"Visibility": 4,
			"Music": "sfx_level_3"
		},
		"LEVELS": {
			"Level_4": 100
		},
		"MOBS": {
			"GruntInfected": 75,
			"Goo": 25,
			"Horror": 35,
			"Sludge": 50,
			"MindFlayer": 25
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"ShieldGenerator": 10,
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"EMPGrenade": 10,
				"FragGrenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"Revolver": 5,
				"SawnOff": 0,
				"Shotgun": 0,
				"SubmachineGun": 0,
				"HuntingRifle": 0,
				"AssaultRifle": 75,
				"TacticalShotgun": 75,
				"SniperRifle": 10
			},
			"OTHER": {
#				"BigDan001": 100
			}
		},
	},
	19: {
		"SETTINGS": {
			"IsRandom": true,
			"MinMobCount": 4,
			"MaxMobCount": 6,
			"Visibility": 4,
			"Music": "sfx_level_3"
		},
		"LEVELS": {
			"Level_4": 100
		},
		"MOBS": {
			"GruntInfected": 75,
			"Goo": 20,
			"Horror": 45,
			"Sludge": 75,
			"MindFlayer": 50
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"ShieldGenerator": 10,
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"EMPGrenade": 10,
				"FragGrenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"Revolver": 0,
				"SawnOff": 0,
				"Shotgun": 0,
				"SubmachineGun": 0,
				"HuntingRifle": 0,
				"AssaultRifle": 75,
				"TacticalShotgun": 75,
				"SniperRifle": 15
			},
			"OTHER": {
#				"BigDan001": 100
			}
		},
	},
	20: {
		"SETTINGS": {
			"IsRandom": true,
			"MinMobCount": 5,
			"MaxMobCount": 7,
			"Visibility": 4,
			"Music": "sfx_level_3"
		},
		"LEVELS": {
			"Level_4": 100
		},
		"MOBS": {
			"GruntInfected": 50,
			"Goo": 15,
			"Horror": 50,
			"Sludge": 75,
			"MindFlayer": 75
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"ShieldGenerator": 10,
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"EMPGrenade": 10,
				"FragGrenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"Revolver": 0,
				"SawnOff": 0,
				"Shotgun": 0,
				"SubmachineGun": 0,
				"HuntingRifle": 0,
				"AssaultRifle": 75,
				"TacticalShotgun": 75,
				"SniperRifle": 25
			},
			"OTHER": {
#				"BigDan001": 100
			}
		},
	},
	21: {
		"SETTINGS": {
			"IsRandom": true,
			"MinMobCount": 4,
			"MaxMobCount": 6,
			"Visibility": 3,
			"Music": "sfx_level_5"
		},
		"LEVELS": {
			"Level_5": 100
		},
		"MOBS": {
			"Zealot": 100,
			"Protean": 10,
			"Scout": 0,
			"Stalker": 0,
			"Templar": 0
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"ShieldGenerator": 10,
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"EMPGrenade": 10,
				"FragGrenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"Revolver": 0,
				"SawnOff": 0,
				"Shotgun": 0,
				"SubmachineGun": 0,
				"HuntingRifle": 0,
				"AssaultRifle": 75,
				"TacticalShotgun": 75,
				"SniperRifle": 50
			},
			"OTHER": {
#				"BigDan001": 100
			}
		},
	},
	22: {
		"SETTINGS": {
			"IsRandom": true,
			"MinMobCount": 4,
			"MaxMobCount": 6,
			"Visibility": 3,
			"Music": "sfx_level_5"
		},
		"LEVELS": {
			"Level_5": 100
		},
		"MOBS": {
			"Zealot": 100,
			"Protean": 15,
			"Scout": 25,
			"Stalker": 10,
			"Templar": 5
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"ShieldGenerator": 10,
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"EMPGrenade": 10,
				"FragGrenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"Revolver": 0,
				"SawnOff": 0,
				"Shotgun": 0,
				"SubmachineGun": 0,
				"HuntingRifle": 0,
				"AssaultRifle": 75,
				"TacticalShotgun": 75,
				"SniperRifle": 75
			},
			"OTHER": {
#				"BigDan001": 100
			}
		},
	},
	23: {
		"SETTINGS": {
			"IsRandom": true,
			"MinMobCount": 5,
			"MaxMobCount": 7,
			"Visibility": 3,
			"Music": "sfx_level_5"
		},
		"LEVELS": {
			"Level_5": 100
		},
		"MOBS": {
			"Zealot": 75,
			"Protean": 20,
			"Scout": 50,
			"Stalker": 25,
			"Templar": 15
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"ShieldGenerator": 10,
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"EMPGrenade": 10,
				"FragGrenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"Revolver": 0,
				"SawnOff": 0,
				"Shotgun": 0,
				"SubmachineGun": 0,
				"HuntingRifle": 0,
				"AssaultRifle": 75,
				"TacticalShotgun": 75,
				"SniperRifle": 75
			},
			"OTHER": {
#				"BigDan001": 100
			}
		},
	},
	24: {
		"SETTINGS": {
			"IsRandom": true,
			"MinMobCount": 5,
			"MaxMobCount": 7,
			"Visibility": 3,
			"Music": "sfx_level_5"
		},
		"LEVELS": {
			"Level_5": 100
		},
		"MOBS": {
			"Zealot": 50,
			"Protean": 25,
			"Scout": 75,
			"Stalker": 50,
			"Templar": 40
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"ShieldGenerator": 10,
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"EMPGrenade": 10,
				"FragGrenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"Revolver": 0,
				"SawnOff": 0,
				"Shotgun": 0,
				"SubmachineGun": 0,
				"HuntingRifle": 0,
				"AssaultRifle": 75,
				"TacticalShotgun": 75,
				"SniperRifle": 75
			},
			"OTHER": {
#				"BigDan001": 100
			}
		},
	},
	25: {
		"SETTINGS": {
			"IsRandom": true,
			"MinMobCount": 6,
			"MaxMobCount": 8,
			"Visibility": 3,
			"Music": "sfx_level_5"
		},
		"LEVELS": {
			"Level_5": 100
		},
		"MOBS": {
			"Zealot": 25,
			"Protean": 25,
			"Scout": 75,
			"Stalker": 75,
			"Templar": 50
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"ShieldGenerator": 10,
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"EMPGrenade": 10,
				"FragGrenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"Revolver": 0,
				"SawnOff": 0,
				"Shotgun": 0,
				"SubmachineGun": 0,
				"HuntingRifle": 0,
				"AssaultRifle": 75,
				"TacticalShotgun": 75,
				"SniperRifle": 75
			},
			"OTHER": {
#				"BigDan001": 100
			}
		},
	},
	26: {
		"SETTINGS": {
			"IsRandom": false,
			"MinMobCount": 0,
			"MaxMobCount": 0,
			"Visibility": 8,
			"Music": "sfx_level_5"
		},
		"LEVELS": {
			"Level_6": 100
		},
		"MOBS": {
		},
		"ITEMS": {
			"COMMON": {
			},
			"CONSUMABLES": {
			},
			"WEAPONS": {
			},
			"OTHER": {
			}
		},
	},
}
