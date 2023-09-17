extends Control

@onready var label = $Label

var hpLabel = "HP = "
var stats = PlayerStats

var hearts: int = 10:
	get:
		return hearts
	set(value):
		hearts = clamp(value, 0, max_hearts)
		if label != null:
			label.text = hpLabel + str(self.hearts)
		
var max_hearts: int = 10:
	get:
		return max_hearts
	set(value):
		max_hearts = max(value, 1)
		
func _ready():
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health
	PlayerStats.changed_health.connect(set_hearts)

func set_hearts(value):
	hearts = value
