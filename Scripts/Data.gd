extends Node

onready var shotgun = preload("res://Items/Shotgun.tscn")
onready var assault_rifle = preload("res://Items/AssaultRifle.tscn")
onready var pistol = preload("res://Items/Pistol.tscn")

# TEXT
#---------------------------------------------------------------------------------------
onready var TEXT_DATA = {
	"text_0": "this is text 0",
	"text_1": "this is text 1",
	"text_2": "this is text 2"
}

# LEVELS
#---------------------------------------------------------------------------------------
onready var LEVEL_DATA = {
	0: {
		"SETTINGS": {
			"Visibility": 0,
			"Music": "none"
		},
		"LEVELS": {
			"Level_1": 100
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
	1: {
		"SETTINGS": {
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
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 50,
				"SawnOff": 50,
				"Shotgun": 50,
				"SubmachineGun": 50,
				"HuntingRifle": 5,
				"AssaultRifle": 1,
				"TacticalShotgun": 0,
				"SniperRifle": 0
			},
			"OTHER": {
				"BigDan001": 100
			}
		},
	},
	2: {
		"SETTINGS": {
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
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 25,
				"SawnOff": 25,
				"Shotgun": 45,
				"SubmachineGun": 45,
				"HuntingRifle": 25,
				"AssaultRifle": 0,
				"TacticalShotgun": 0,
				"SniperRifle": 0
			},
			"OTHER": {
				"BigDan001": 100
			}
		},
	},
	3: {
		"SETTINGS": {
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
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 10,
				"SawnOff": 10,
				"Shotgun": 40,
				"SubmachineGun": 40,
				"HuntingRifle": 40,
				"AssaultRifle": 0,
				"TacticalShotgun": 0,
				"SniperRifle": 0
			},
			"OTHER": {
				"BigDan001": 100
			}
		},
	},
	4: {
		"SETTINGS": {
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
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"SawnOff": 0,
				"Shotgun": 40,
				"SubmachineGun": 40,
				"HuntingRifle": 40,
				"AssaultRifle": 0,
				"TacticalShotgun": 0,
				"SniperRifle": 0
			},
			"OTHER": {
				"BigDan001": 100
			}
		},
	},
	5: {
		"SETTINGS": {
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
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"SawnOff": 0,
				"Shotgun": 40,
				"SubmachineGun": 40,
				"HuntingRifle": 40,
				"AssaultRifle": 1,
				"TacticalShotgun": 1,
				"SniperRifle": 0
			},
			"OTHER": {
				"BigDan001": 100
			}
		},
	},
	6: {
		"SETTINGS": {
			"Visibility": 6,
			"Music": "sfx_level_0"
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
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"SawnOff": 0,
				"Shotgun": 35,
				"SubmachineGun": 35,
				"HuntingRifle": 35,
				"AssaultRifle": 5,
				"TacticalShotgun": 5,
				"SniperRifle": 0
			},
			"OTHER": {
				"BigDan001": 100
			}
		},
	},
	7: {
		"SETTINGS": {
			"Visibility": 6,
			"Music": "sfx_level_0"
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
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"SawnOff": 0,
				"Shotgun": 30,
				"SubmachineGun": 30,
				"HuntingRifle": 30,
				"AssaultRifle": 8,
				"TacticalShotgun": 8,
				"SniperRifle": 0
			},
			"OTHER": {
				"BigDan001": 100
			}
		},
	},
	8: {
		"SETTINGS": {
			"Visibility": 6,
			"Music": "sfx_level_0"
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
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"SawnOff": 0,
				"Shotgun": 25,
				"SubmachineGun": 25,
				"HuntingRifle": 25,
				"AssaultRifle": 10,
				"TacticalShotgun": 10,
				"SniperRifle": 0
			},
			"OTHER": {
				"BigDan001": 100
			}
		},
	},
	9: {
		"SETTINGS": {
			"Visibility": 6,
			"Music": "sfx_level_0"
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
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"SawnOff": 0,
				"Shotgun": 15,
				"SubmachineGun": 15,
				"HuntingRifle": 15,
				"AssaultRifle": 10,
				"TacticalShotgun": 10,
				"SniperRifle": 0
			},
			"OTHER": {
				"BigDan001": 100
			}
		},
	},
	10: {
		"SETTINGS": {
			"Visibility": 6,
			"Music": "sfx_level_0"
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
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"SawnOff": 0,
				"Shotgun": 15,
				"SubmachineGun": 15,
				"HuntingRifle": 15,
				"AssaultRifle": 15,
				"TacticalShotgun": 15,
				"SniperRifle": 1
			},
			"OTHER": {
				"BigDan001": 100
			}
		},
	},
	11: {
		"SETTINGS": {
			"Visibility": 5,
			"Music": "sfx_level_0"
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
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"SawnOff": 0,
				"Shotgun": 10,
				"SubmachineGun": 10,
				"HuntingRifle": 10,
				"AssaultRifle": 25,
				"TacticalShotgun": 25,
				"SniperRifle": 1
			},
			"OTHER": {
				"BigDan001": 100
			}
		},
	},
	12: {
		"SETTINGS": {
			"Visibility": 5,
			"Music": "sfx_level_0"
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
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"SawnOff": 0,
				"Shotgun": 10,
				"SubmachineGun": 10,
				"HuntingRifle": 10,
				"AssaultRifle": 35,
				"TacticalShotgun": 35,
				"SniperRifle": 1
			},
			"OTHER": {
				"BigDan001": 100
			}
		},
	},
	13: {
		"SETTINGS": {
			"Visibility": 5,
			"Music": "sfx_level_0"
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
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"SawnOff": 0,
				"Shotgun": 10,
				"SubmachineGun": 10,
				"HuntingRifle": 10,
				"AssaultRifle": 50,
				"TacticalShotgun": 50,
				"SniperRifle": 1
			},
			"OTHER": {
				"BigDan001": 100
			}
		},
	},
	14: {
		"SETTINGS": {
			"Visibility": 5,
			"Music": "sfx_level_0"
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
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"SawnOff": 0,
				"Shotgun": 5,
				"SubmachineGun": 5,
				"HuntingRifle": 5,
				"AssaultRifle": 75,
				"TacticalShotgun": 75,
				"SniperRifle": 1
			},
			"OTHER": {
				"BigDan001": 100
			}
		},
	},
	15: {
		"SETTINGS": {
			"Visibility": 5,
			"Music": "sfx_level_0"
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
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"SawnOff": 0,
				"Shotgun": 5,
				"SubmachineGun": 5,
				"HuntingRifle": 5,
				"AssaultRifle": 75,
				"TacticalShotgun": 75,
				"SniperRifle": 5
			},
			"OTHER": {
				"BigDan001": 100
			}
		},
	},
	16: {
		"SETTINGS": {
			"Visibility": 4,
			"Music": "sfx_level_0"
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
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"SawnOff": 0,
				"Shotgun": 0,
				"SubmachineGun": 0,
				"HuntingRifle": 0,
				"AssaultRifle": 75,
				"TacticalShotgun": 75,
				"SniperRifle": 10
			},
			"OTHER": {
				"BigDan001": 100
			}
		},
	},
	17: {
		"SETTINGS": {
			"Visibility": 4,
			"Music": "sfx_level_0"
		},
		"LEVELS": {
			"Level_4": 100
		},
		"MOBS": {
			"GruntInfected": 100,
			"Goo": 75,
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
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"SawnOff": 0,
				"Shotgun": 0,
				"SubmachineGun": 0,
				"HuntingRifle": 0,
				"AssaultRifle": 75,
				"TacticalShotgun": 75,
				"SniperRifle": 10
			},
			"OTHER": {
				"BigDan001": 100
			}
		},
	},
	18: {
		"SETTINGS": {
			"Visibility": 4,
			"Music": "sfx_level_0"
		},
		"LEVELS": {
			"Level_4": 100
		},
		"MOBS": {
			"GruntInfected": 75,
			"Goo": 75,
			"Horror": 75,
			"Sludge": 50,
			"MindFlayer": 15
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"SawnOff": 0,
				"Shotgun": 0,
				"SubmachineGun": 0,
				"HuntingRifle": 0,
				"AssaultRifle": 75,
				"TacticalShotgun": 75,
				"SniperRifle": 10
			},
			"OTHER": {
				"BigDan001": 100
			}
		},
	},
	19: {
		"SETTINGS": {
			"Visibility": 4,
			"Music": "sfx_level_0"
		},
		"LEVELS": {
			"Level_4": 100
		},
		"MOBS": {
			"GruntInfected": 75,
			"Goo": 75,
			"Horror": 100,
			"Sludge": 75,
			"MindFlayer": 25
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"SawnOff": 0,
				"Shotgun": 0,
				"SubmachineGun": 0,
				"HuntingRifle": 0,
				"AssaultRifle": 75,
				"TacticalShotgun": 75,
				"SniperRifle": 15
			},
			"OTHER": {
				"BigDan001": 100
			}
		},
	},
	20: {
		"SETTINGS": {
			"Visibility": 4,
			"Music": "sfx_level_0"
		},
		"LEVELS": {
			"Level_4": 100
		},
		"MOBS": {
			"GruntInfected": 50,
			"Goo": 100,
			"Horror": 100,
			"Sludge": 100,
			"MindFlayer": 50
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"SawnOff": 0,
				"Shotgun": 0,
				"SubmachineGun": 0,
				"HuntingRifle": 0,
				"AssaultRifle": 75,
				"TacticalShotgun": 75,
				"SniperRifle": 15
			},
			"OTHER": {
				"BigDan001": 100
			}
		},
	},
	211: {
		"SETTINGS": {
			"Visibility": 3,
			"Music": "sfx_level_0"
		},
		"LEVELS": {
			"Level_5": 100
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
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"Pistol": 0,
				"SawnOff": 0,
				"Shotgun": 5,
				"SubmachineGun": 5,
				"HuntingRifle": 0,
				"AssaultRifle": 0,
				"TacticalShotgun": 0,
				"SniperRifle": 0
			},
			"OTHER": {
				"BigDan001": 100
			}
		},
	},
	22: {
		"SETTINGS": {
			"Visibility": 3,
			"Music": "sfx_level_0"
		},
		"LEVELS": {
			"Level_5": 100
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
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"SawnOff": 1,
				"Shotgun": 5,
				"SubmachineGun": 5,
				"HuntingRifle": 0,
				"AssaultRifle": 0,
				"TacticalShotgun": 0,
				"SniperRifle": 0
			},
			"OTHER": {
				"BigDan001": 100
			}
		},
	},
	23: {
		"SETTINGS": {
			"Visibility": 3,
			"Music": "sfx_level_0"
		},
		"LEVELS": {
			"Level_5": 100
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
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"SawnOff": 1,
				"Shotgun": 5,
				"SubmachineGun": 5,
				"HuntingRifle": 0,
				"AssaultRifle": 0,
				"TacticalShotgun": 0,
				"SniperRifle": 0
			},
			"OTHER": {
				"BigDan001": 100
			}
		},
	},
	24: {
		"SETTINGS": {
			"Visibility": 3,
			"Music": "sfx_level_0"
		},
		"LEVELS": {
			"Level_5": 100
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
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"SawnOff": 1,
				"Shotgun": 5,
				"SubmachineGun": 5,
				"HuntingRifle": 0,
				"AssaultRifle": 0,
				"TacticalShotgun": 0,
				"SniperRifle": 0
			},
			"OTHER": {
				"BigDan001": 100
			}
		},
	},
	25: {
		"SETTINGS": {
			"Visibility": 3,
			"Music": "sfx_level_0"
		},
		"LEVELS": {
			"Level_5": 100
		},
		"MOBS": {
			"Wart": 100,
			"Hydra": 100,
			"Behemoth": 100,
			"Infestinator": 100
		},
		"ITEMS": {
			"COMMON": {
				"Ammo": 100,
				"Medkit": 50
			},
			"CONSUMABLES": {
				"Adrenalin": 10,
				"Steroids": 10,
				"Grenade": 10,
				"Teleport": 10
			},
			"WEAPONS": {
				"SawnOff": 1,
				"Shotgun": 5,
				"SubmachineGun": 5,
				"HuntingRifle": 0,
				"AssaultRifle": 0,
				"TacticalShotgun": 0,
				"SniperRifle": 0
			},
			"OTHER": {
				"BigDan001": 100
			}
		},
	},
}
