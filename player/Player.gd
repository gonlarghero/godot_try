extends CharacterBody2D

var borderLimit
const MAX_SPEED = 200;
const ACCELERATION = 20;
const FRICTION = 20;

func _ready():
	borderLimit = get_viewport_rect().size
	
func _physics_process(delta):
	var input_vector = Vector2.ZERO;
	input_vector.x = Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left");
	input_vector.y = Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up");
	input_vector = input_vector.normalized();
	if(input_vector != Vector2.ZERO):
		velocity += input_vector * ACCELERATION * delta;
		velocity = velocity.limit_length(MAX_SPEED * delta);
	else:
		velocity = velocity.move_toward(Vector2.ZERO,FRICTION * delta);
	_animation_change()
	position.x = clamp(position.x, 0, borderLimit.x)
	position.y = clamp(position.y, 0, borderLimit.y)
	move_and_collide(velocity);
	
func _animation_change():
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
