extends CharacterBody2D

enum{
	MOVE,
	ROLL,
	ATTACK,
	RECOVERY
}

var borderLimit
var state = MOVE;
var roll_vector = Vector2.DOWN;
var stats = PlayerStats #ta medio peru este singleton

@export var MAX_SPEED = 200;
@export var ROLL_SPEED = 350
@export var ACCELERATION = 700;
@export var FRICTION = 700;

@onready var animationPlayer = $AnimationPlayer;
@onready var animationTree = $AnimationTree;
@onready var animationState = animationTree.get("parameters/playback")
@onready var swordHitbox = $Marker2D/hitbox
@onready var hurtbox = $HurtBox

func _ready():
	self.stats.connect("no_health", queue_free)
	get_node("Marker2D/hitbox/CollisionShape2D").disabled = true   
	borderLimit = get_viewport_rect().size;
	animationTree.active = true;
	swordHitbox.knockback_vector = roll_vector
	
func _process(delta):
	match state:
		MOVE: 
			move_state(delta);
		ROLL: 
			roll_state();
		ATTACK:
			attack_state();
		RECOVERY:
			recovery_health()
		
					
func move_state(delta):
	var input_vector = Vector2.ZERO;
	input_vector.x = Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left");
	input_vector.y = Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up");
	input_vector = input_vector.normalized();
	
	if(input_vector != Vector2.ZERO):	
		animationTree.set("parameters/Idle/blend_position",input_vector);
		animationTree.set("parameters/Run/blend_position",input_vector);
		animationTree.set("parameters/Attack/blend_position",input_vector);
		animationTree.set("parameters/Roll/blend_position",input_vector);
		roll_vector = input_vector	
		swordHitbox.knockback_vector = input_vector
		animationState.travel("Run");
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta);
	else:
		animationState.travel("Idle");
		velocity = velocity.move_toward(Vector2.ZERO,FRICTION * delta);
	
	if(Input.is_action_just_pressed("Roll")):
		state = ROLL;
		
	if(Input.is_action_just_pressed("Attack")):
		state = ATTACK;
		
	if(Input.is_action_just_pressed("recovery_health")):
		state = RECOVERY
	
	position.x = clamp(position.x, 0, borderLimit.x)
	position.y = clamp(position.y, 0, borderLimit.y)
	move_and_slide();

func roll_state():
	velocity = roll_vector * ROLL_SPEED
	animationState.travel("Roll");
	move_and_slide();
	
func attack_state():
	velocity = Vector2.ZERO;
	animationState.travel("Attack");

func attack_ended():
	state = MOVE;
	
func roll_ended():
	state = MOVE;
	
func recovery_health():
	PlayerStats.recovery_health()
	state = MOVE

func _on_hurt_box_area_entered(area):
	stats.health -= 1
	hurtbox.start_invincibility(1.0)
	hurtbox.create_hit_effect()
