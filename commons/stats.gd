extends Node

signal no_health
signal changed_health(value)
signal max_health_changed(value)

@export var max_health: int = 1:
	get:
		return max_health
	set(value):
		max_health = value
		self.health = min(health, max_health)
		emit_signal("max_health_changed", max_health)
		
var health = max_health:
	get: 
		return health
	set(value): 
		health = value
		emit_signal("changed_health", health)
		if health <= 0:
			emit_signal("no_health")		

func _ready():
	self.health = max_health

func recovery_health():
	self.health = max_health
