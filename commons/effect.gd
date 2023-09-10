extends AnimatedSprite2D

func _ready():
	self.animation_finished.connect(_on_grass_animation_animation_finished)
	frame = 0;
	play("Animate");

func _on_grass_animation_animation_finished():
	queue_free();
