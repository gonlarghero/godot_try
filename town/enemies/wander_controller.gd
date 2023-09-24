extends Node2D

@export var wander_range:int = 32

@onready var start_position = global_position
@onready var target_position = global_position
@onready var timer = $Timer

func _ready():
	update_target_position()
	
func _on_timer_timeout():
		update_target_position()

func update_target_position():
	var target_vector = Vector2(randi_range(-wander_range, wander_range), randi_range(-wander_range, wander_range))
	target_position = start_position + target_vector

func evaluate_time_left(min, max):
	var time_left = timer.time_left
	if time_left == 0:
		_start_timer(randi_range(min, max))
	return time_left
	
func return_to_start_position():
	target_position = start_position
	
func _start_timer(duration):
	timer.start(duration)
