extends Area2D

@export var show_hit : bool = true

const hit_effect_scn = preload("res://town/effects/hit_effect.tscn");

func _on_area_entered(_area):
	if !show_hit:
		return
	var hit_effect = hit_effect_scn.instantiate()
	var main = get_tree().current_scene
	main.add_child(hit_effect)
	hit_effect.global_position = global_position
