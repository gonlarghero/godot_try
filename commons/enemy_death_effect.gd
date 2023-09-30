extends AnimatedSprite2D

@onready var audioStream = $AudioStreamPlayer2D

func _ready():
	self.animation_finished.connect(_on_grass_animation_animation_finished)
	frame = 0;
	play("Animate");

func _on_grass_animation_animation_finished():
	self.audioStream.finished.connect(_on_audio_finished)

func _on_audio_finished():
	queue_free();
