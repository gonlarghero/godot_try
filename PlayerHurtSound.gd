extends AudioStreamPlayer2D

func _ready():
	self.connect("finished", queue_free)
