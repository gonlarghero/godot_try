extends CharacterBody2D

func _on_hurt_box_area_entered(area):
	queue_free();
