extends CharacterBody2D

var map_limit = preload("res://commons/map/limit.gd").new()		

const MAX_SPEED = 200
const ACCELERATION = 1000
const FRICTION = 1000

@onready var animationPlayer = $AnimationPlayer;
@onready var animationTree = $AnimationTree;
@onready var animationState = animationTree.get("parameters/playback")

func _ready():
	map_limit.init_limit(self)
	
func _physics_process(delta):
	move_main_character(delta)
	map_limit.set_limit(self);

func move_main_character(delta):  # Recibir las referencias como argumentos
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position",input_vector);
		animationTree.set("parameters/Run/blend_position",input_vector);
		animationState.travel("Run");
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta);
	else:
		animationState.travel("Idle");
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	move_and_slide()
