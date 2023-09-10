extends CharacterBody2D

@export var MAX_SPEED = 50;
@export var ACCELERATION = 100;
@export var FRICTION = 50;

const EnemyDeathEffect = preload("res://commons/enemy_death_effect.tscn")

enum {
	IDLE,
	WANDER,
	CHASE,
	GONDA	
}

var state = CHASE

@onready var sprite = $SpriteBat
@onready var stats = $Stats
@onready var playerDetectionZone = $PlayerDetectionZone

func _physics_process(delta):	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta);
			seek_player()
		WANDER:
			pass
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
				sprite.flip_h = velocity.x < 0
			else:
				state = IDLE
		GONDA:
			pass
	move_and_slide()
	
func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE
	
func _on_hurt_box_area_entered(area):
	stats.health -= area.damage
	velocity = area.knockback_vector * 120
	
func _on_stats_no_health():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instantiate()
	get_parent().add_child(enemyDeathEffect);
	enemyDeathEffect.global_position = global_position;
