extends Node2D

const GrassEffect = preload("res://commons/grass_effect.tscn")

func _on_hurt_box_area_entered(area):
	_create_grass_effect();
	queue_free();

func _create_grass_effect():
	var grass_effect = GrassEffect.instantiate();
	get_parent().add_child(grass_effect);
	grass_effect.global_position = global_position;
