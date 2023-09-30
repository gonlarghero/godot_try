extends CharacterBody2D

@export var MAX_SPEED = 50;
@export var ACCELERATION = 100;
@export var FRICTION = 50;
@export var MIN_WANDER_TIME = 1;
@export var MAX_WANDER_TIME = 3;

const EnemyDeathEffect = preload("res://commons/enemy_death_effect.tscn")
@export var sound = preload("res://assets/enemies/Music and Sounds/EnemyDie.wav")

enum {
	IDLE,
	WANDER,
	CHASE,
	GONDA	
}

var state = WANDER

@onready var sprite = $SpriteBat
@onready var stats = $Stats
@onready var playerDetectionZone = $PlayerDetectionZone
@onready var hurtbox = $HurtBox
@onready var soft_collision = $SoftColission
@onready var wanderController = $WanderController

func _ready():
	state = pick_random_state([IDLE,WANDER,WANDER])
	
func _physics_process(delta):	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta);
			seek_player()
			
			if wanderController.evaluate_time_left(MIN_WANDER_TIME, MAX_WANDER_TIME) == 0:
				state = pick_random_state([IDLE, WANDER, WANDER])
		WANDER:
			seek_player()
			if wanderController.evaluate_time_left(MIN_WANDER_TIME, MAX_WANDER_TIME) == 0:
				state = pick_random_state([IDLE, WANDER, WANDER])
			
			accelerate_towards_point(wanderController.target_position, delta)
			
			if global_position.distance_to(wanderController.target_position) <= MAX_SPEED / 4:
				state = pick_random_state([IDLE, WANDER])
				wanderController.evaluate_time_left(MIN_WANDER_TIME, MAX_WANDER_TIME)	
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				accelerate_towards_point(player.global_position, delta)
			else:
				state = IDLE
				wanderController.return_to_start_position()
		GONDA:
			pass
	if(soft_collision.is_colliding()):
		velocity += soft_collision.get_push_vector() * delta * 400; 
	move_and_slide()
	
func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE
	
func _on_hurt_box_area_entered(area):
	stats.health -= area.damage
	velocity = area.knockback_vector * 120
	hurtbox.create_hit_effect()
	
func _on_stats_no_health():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instantiate()
	get_parent().add_child(enemyDeathEffect);
	enemyDeathEffect.global_position = global_position;
	var audioStream = enemyDeathEffect.get_node("AudioStreamPlayer2D")
	audioStream.stream = sound
	audioStream.play()
	
	
func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0
