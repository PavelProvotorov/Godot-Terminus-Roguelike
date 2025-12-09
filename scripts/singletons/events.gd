extends Node

signal game_started()
signal player_moved(pos, distance)
signal player_health_changed(health)
signal player_buffs_changed(buffs)
signal player_ammo_changed(ammo)
signal level_generation_complete(level)
signal level_door_opened()
signal level_fog_updated(cells)
signal level_descended()
signal end_turn(node) 
