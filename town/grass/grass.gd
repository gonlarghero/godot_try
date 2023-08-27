extends Node2D

func _on_hurt_box_area_entered(_area):
	_create_grass_effect();
	queue_free();

func _create_grass_effect():
	var grass_effect_scn = load("res://town/grass/grass_effect.tscn");
	var grass_effect = grass_effect_scn.instantiate();
	var world = get_tree().current_scene;
	world.add_child(grass_effect);
	grass_effect.global_position = global_position;
