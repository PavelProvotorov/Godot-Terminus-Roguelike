extends Node

onready var text_label = preload("res://scenes/TextLabel.tscn")
onready var scene_description = preload("res://scenes/Description.tscn")
onready var debug_label = preload("res://scenes/DebugLabel.tscn")
onready var debug_vermin = preload("res://scenes/mobs/Vermin.tscn")
onready var debug_colony = preload("res://scenes/mobs/Colony.tscn")
onready var debug_player = preload("res://scenes/mobs/Player.tscn")
onready var debug_maggot = preload("res://scenes/mobs/Maggot.tscn")
onready var debug_creep = preload("res://scenes/mobs/Creep.tscn")
onready var debug_grunt = preload("res://scenes/mobs/Grunt.tscn")
onready var debug_goo = preload("res://scenes/mobs/Goo.tscn")

onready var weapon_shotgun = load("res://scenes/weapons/Shotgun.tscn")
onready var weapon_hunting_rifle = load("res://scenes/weapons/HuntingRifle.tscn")
