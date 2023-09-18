extends Control

@onready var pixelHeartWidht: int = 15
@onready var fullHeart = $HearthUIFull
@onready var emptyHeart = $HearthUIEmpty

var hpLabel = "HP = "
var stats = PlayerStats

@onready var hearts: int:
	get:
		return hearts
	set(value):
		hearts = clamp(value, 0, max_hearts)
		if fullHeart != null:
			fullHeart.size.x = hearts * pixelHeartWidht
		
@onready var max_hearts: int:
	get:
		return max_hearts
	set(value):
		max_hearts = max(value, 1)
		self.hearts = min(hearts, max_hearts)
		if emptyHeart != null:
			emptyHeart.size.x = max_hearts * pixelHeartWidht
			fullHeart.size.x = max_hearts * pixelHeartWidht
		
func _ready():
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health
	PlayerStats.changed_health.connect(set_hearts)
	PlayerStats.max_health_changed.connect(set_max_hearts)
	
func set_hearts(value):
	hearts = value

func set_max_hearts(value):
	max_hearts = value
