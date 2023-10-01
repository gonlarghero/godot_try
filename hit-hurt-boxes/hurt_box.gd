extends Area2D

const HitEffect = preload("res://commons/HitEffect.tscn")
  
signal invincibility_started
signal invincibility_ended

@onready var timer = $Timer
@onready var colissionShape = $CollisionShape2D
					
func create_hit_effect():
	var effect = HitEffect.instantiate()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position

func start_invincibility(duration):
	emit_signal("invincibility_started")
	timer.start(duration)

func _on_timer_timeout():
	emit_signal("invincibility_ended")

func _on_invincibility_started():
	colissionShape.set_deferred("disabled", true)
	
func _on_invincibility_ended():
	colissionShape.disabled = false

