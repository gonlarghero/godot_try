extends Node

signal no_health
signal changed_health(value)

@export var max_health: int = 1
@onready var health = max_health:
	get: 
		return health
	set(value): 
		health = value
		emit_signal("changed_health", health)
		if health <= 0:
			emit_signal("no_health")		

