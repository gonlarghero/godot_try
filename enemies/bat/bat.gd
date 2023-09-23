extends CharacterBody2D

var knockback = Vector2.ZERO
var state = IDLE;

@onready var hurtbox = $HurtBox
@onready var sprite = $Animation
@onready var stats = $stats;
@onready var player_detection_zone = $PlayerDetectionZone
@onready var soft_collision = $SoftCollision

@export var MAX_SPEED = 500;
@export var ACCELERATION = 200;
@export var FRICTION = 200;

enum{
	IDLE,
	WANDER,
	CHASE
}

const enemy_death_effect_scn = preload("res://town/effects/enemy_death_effect.tscn");

func _physics_process(delta):
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta);
			seek_player()
		WANDER:
			pass
		CHASE:
			var player = player_detection_zone.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
				sprite.flip_h = velocity.x < 0
			else:
				state = IDLE	
	if(soft_collision.is_colliding()):
		velocity += soft_collision.get_push_vector() * delta * 400; 
	move_and_slide()
				
func seek_player():
	if player_detection_zone.can_see_player():
		state = CHASE
	
func _on_hurt_box_area_entered(area):
	stats.health -= area.damage;
	velocity = area.knockback_vector * 120;
	hurtbox.create_hit_effect(area);

func _on_stats_no_health():
	var enemy_death_effect = enemy_death_effect_scn.instantiate();
	get_parent().add_child(enemy_death_effect);
	enemy_death_effect.global_position = global_position;
	queue_free()
