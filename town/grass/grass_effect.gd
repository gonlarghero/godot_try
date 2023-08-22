extends Node2D

@onready var grass_animation = $grass_animation; 

func _ready():
	grass_animation.frame = 0;
	grass_animation.play("grass_death");

func _on_grass_animation_animation_finished():
	queue_free();
