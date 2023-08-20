extends CharacterBody2D

var map_limit = preload("res://commons/map/limit.gd").new()		

const MAX_SPEED = 200
const ACCELERATION = 1000
const FRICTION = 1000

func _ready():
	map_limit.init_limit(self)
	
func _physics_process(delta):
	move_main_character(delta)
	animate_main_character()
	map_limit.set_limit(self);

func move_main_character(delta):  # Recibir las referencias como argumentos
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta);
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	move_and_slide()
	
func animate_main_character():
	if velocity.x != 0:
		if velocity.x < 0:
			$player_sprite.animation = "left"
			$player_sprite.play("left")
		else:
			$player_sprite.animation = "right"
			$player_sprite.play("right")
	elif velocity.y != 0:
		if velocity.y < 0:
			$player_sprite.animation = "up"
			$player_sprite.play("up")
		else:
			$player_sprite.animation = "down"
			$player_sprite.play("down")
	else:
		$player_sprite.animation = "idle"
		$player_sprite.play("idle")
