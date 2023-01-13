extends Node

var shotgun = preload("res://Items/Shotgun.tscn")

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
	1: {
		"LEVELS": {
			"Level_1": 100
		},
		"MOBS": {
			"Grunt": 100,
			"Parasite": 25,
			"Colony": 5
		},
		"ITEMS": {
			"Ammo": 100,
			"Medkit": 100,
			"Adrenalin": 10,
			"Steroids": 10,
			"Grenade": 10,
			"Teleport": 10,
			"TacticalShotgun": 5,
			"AssaultRifle": 5,
			"SubmachineGun": 5,
			"HuntingRifle": 5,
			"SniperRifle": 5,
			"SawnOff": 5,
			"Shotgun": 5,
			"BigDan001": 5
		},
	},
	2: {
		"LEVELS": {
			"Level_1": 100
		},
		"MOBS": {
			"Grunt": 100,
			"Parasite": 50,
			"Bloater": 25,
			"Colony": 10
		},
		"ITEMS": {
			"Ammo": 100,
			"Medkit": 100,
			"Adrenalin": 10,
			"Steroids": 10,
			"Grenade": 10,
			"Teleport": 10,
			"TacticalShotgun": 5,
			"AssaultRifle": 5,
			"SubmachineGun": 5,
			"HuntingRifle": 5,
			"SniperRifle": 5,
			"SawnOff": 5,
			"Shotgun": 5,
			"BigDan001": 5
		},
	},
	3: {
		"LEVELS": {
			"Level_1": 100
		},
		"MOBS": {
			"Grunt": 100,
			"Parasite": 100,
			"Bloater": 50,
			"Colony": 15
		},
		"ITEMS": {
			"Ammo": 100,
			"Medkit": 100,
			"Adrenalin": 10,
			"Steroids": 10,
			"Grenade": 10,
			"Teleport": 10,
			"TacticalShotgun": 5,
			"AssaultRifle": 5,
			"SubmachineGun": 5,
			"HuntingRifle": 5,
			"SniperRifle": 5,
			"SawnOff": 5,
			"Shotgun": 5,
			"BigDan001": 5
		},
	},
	4: {
		"LEVELS": {
			"Level_1": 100
		},
		"MOBS": {
			"Grunt": 100,
			"Parasite": 100,
			"Bloater": 75,
			"Colony": 25
		},
		"ITEMS": {
			"Ammo": 100,
			"Medkit": 100,
			"Adrenalin": 10,
			"Steroids": 10,
			"Grenade": 10,
			"Teleport": 10,
			"TacticalShotgun": 5,
			"AssaultRifle": 5,
			"SubmachineGun": 5,
			"HuntingRifle": 5,
			"SniperRifle": 5,
			"SawnOff": 5,
			"Shotgun": 5,
			"BigDan001": 5
		},
	},
	5: {
		"LEVELS": {
			"Level_2": 100
		},
		"MOBS": {
			"GruntInfected": 100,
			"Goo": 50,
			"Horror": 25
		},
		"ITEMS": {
			"Ammo": 100,
			"Medkit": 100,
			"Adrenalin": 10,
			"Steroids": 10,
			"Grenade": 10,
			"Teleport": 10,
			"TacticalShotgun": 5,
			"AssaultRifle": 5,
			"SubmachineGun": 5,
			"HuntingRifle": 5,
			"SniperRifle": 5,
			"SawnOff": 5,
			"Shotgun": 5,
			"BigDan001": 5
		},
	},
	6: {
		"LEVELS": {
			"Level_2": 100
		},
		"MOBS": {
			"GruntInfected": 100,
			"Goo": 75,
			"Horror": 25,
			"Sludge": 50 
		},
		"ITEMS": {
			"Ammo": 100,
			"Medkit": 100,
			"Adrenalin": 10,
			"Steroids": 10,
			"Grenade": 10,
			"Teleport": 10,
			"TacticalShotgun": 5,
			"AssaultRifle": 5,
			"SubmachineGun": 5,
			"HuntingRifle": 5,
			"SniperRifle": 5,
			"SawnOff": 5,
			"Shotgun": 5,
			"BigDan001": 5
		},
	},
	7: {
		"LEVELS": {
			"Level_2": 100
		},
		"MOBS": {
			"GruntInfected": 100,
			"Goo": 100,
			"Horror": 50,
			"Sludge": 75 
		},
		"ITEMS": {
			"Ammo": 100,
			"Medkit": 100,
			"Adrenalin": 10,
			"Steroids": 10,
			"Grenade": 10,
			"Teleport": 10,
			"TacticalShotgun": 5,
			"AssaultRifle": 5,
			"SubmachineGun": 5,
			"HuntingRifle": 5,
			"SniperRifle": 5,
			"SawnOff": 5,
			"Shotgun": 5,
			"BigDan001": 5
		},
	},
	8: {
		"LEVELS": {
			"Level_2": 100
		},
		"MOBS": {
			"GruntInfected": 100,
			"Goo": 100,
			"Horror": 75,
			"Sludge": 100 
		},
		"ITEMS": {
			"Ammo": 100,
			"Medkit": 100,
			"Adrenalin": 10,
			"Steroids": 10,
			"Grenade": 10,
			"Teleport": 10,
			"TacticalShotgun": 5,
			"AssaultRifle": 5,
			"SubmachineGun": 5,
			"HuntingRifle": 5,
			"SniperRifle": 5,
			"SawnOff": 5,
			"Shotgun": 5,
			"BigDan001": 5
		},
	},
	9: {
		"LEVELS": {
			"Level_3": 100
		},
		"MOBS": {
			"Wart": 100,
			"Hydra": 50,
			"Behemoth": 25,
			"Infestinator": 5,
		},
		"ITEMS": {
			"Ammo": 100,
			"Medkit": 100,
			"Adrenalin": 10,
			"Steroids": 10,
			"Grenade": 10,
			"Teleport": 10,
			"TacticalShotgun": 5,
			"AssaultRifle": 5,
			"SubmachineGun": 5,
			"HuntingRifle": 5,
			"SniperRifle": 5,
			"SawnOff": 5,
			"Shotgun": 5,
			"BigDan001": 5
		},
	},
	10: {
		"LEVELS": {
			"Level_3": 100
		},
		"MOBS": {
			"Wart": 100,
			"Hydra": 75,
			"Behemoth": 50,
			"Infestinator": 25
		},
		"ITEMS": {
			"Ammo": 100,
			"Medkit": 100,
			"Adrenalin": 10,
			"Steroids": 10,
			"Grenade": 10,
			"Teleport": 10,
			"TacticalShotgun": 5,
			"AssaultRifle": 5,
			"SubmachineGun": 5,
			"HuntingRifle": 5,
			"SniperRifle": 5,
			"SawnOff": 5,
			"Shotgun": 5,
			"BigDan001": 5
		},
	},
	11: {
		"LEVELS": {
			"Level_3": 100
		},
		"MOBS": {
			"Wart": 100,
			"Hydra": 100,
			"Behemoth": 75,
			"Infestinator": 50
		},
		"ITEMS": {
			"Ammo": 100,
			"Medkit": 100,
			"Adrenalin": 10,
			"Steroids": 10,
			"Grenade": 10,
			"Teleport": 10,
			"TacticalShotgun": 5,
			"AssaultRifle": 5,
			"SubmachineGun": 5,
			"HuntingRifle": 5,
			"SniperRifle": 5,
			"SawnOff": 5,
			"Shotgun": 5,
			"BigDan001": 5
		},
	},
	12: {
		"LEVELS": {
			"Level_3": 100
		},
		"MOBS": {
			"Wart": 100,
			"Hydra": 100,
			"Behemoth": 100,
			"Infestinator": 100
		},
		"ITEMS": {
			"Ammo": 100,
			"Medkit": 100,
			"Adrenalin": 10,
			"Steroids": 10,
			"Grenade": 10,
			"Teleport": 10,
			"TacticalShotgun": 5,
			"AssaultRifle": 5,
			"SubmachineGun": 5,
			"HuntingRifle": 5,
			"SniperRifle": 5,
			"SawnOff": 5,
			"Shotgun": 5,
			"BigDan001": 5
		},
	},
}
