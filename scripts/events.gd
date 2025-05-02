extends Node

signal enemy_spawned(pos)
signal enemy_moved(prev_pos, new_pos)
signal player_moved(pos, distance)
signal level_door_open(entity_pos, door_pos, distance)
signal level_generation_complete(entrance)
signal level_fog_updated(cells)
signal end_turn(node) 
