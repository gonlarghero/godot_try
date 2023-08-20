extends CharacterBody2D

# imports
var ch_movement = preload("res://scripts/commons/character/movement.gd").new()	
var map_limit = preload("res://scripts/commons/map/limit.gd").new()		

func _ready():
	map_limit.init_limit(self)
	
func _physics_process(delta):
	ch_movement.move_main_character(self, delta, $player_sprite)
	ch_movement.animate_main_character(self, $player_sprite)
	map_limit.set_limit(self);



