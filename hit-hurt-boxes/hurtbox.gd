extends Area2D

signal invincibility_started
signal invincibility_ended

@onready var timer = $Timer

const hit_effect_scn = preload("res://town/effects/hit_effect.tscn");

func create_hit_effect(_area):
	var hit_effect = hit_effect_scn.instantiate()
	var main = get_tree().current_scene
	main.add_child(hit_effect)
	hit_effect.global_position = global_position

func start_invincibility(duration):
	emit_signal("invincibility_started")
	timer.start(duration)

func _on_timer_timeout():
	emit_signal("invincibility_ended")

func _on_invincibility_started():
	set_deferred("monitorable", false)
	
func _on_invincibility_ended():
	set_deferred("monitorable", true)
