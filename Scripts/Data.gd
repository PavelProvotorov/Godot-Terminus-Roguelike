extends Node

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
			"Shotgun": 5
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
			"Shotgun": 5
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
#			"Hydra": 25,
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
			"Shotgun": 5
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
#			"Hydra": 50,
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
			"Shotgun": 5
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
			"Shotgun": 5
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
			"Shotgun": 5
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
			"Shotgun": 5
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
			"Shotgun": 5
		},
	},
}
