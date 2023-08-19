extends CharacterBody2D

var borderLimit

func _ready():
	borderLimit = get_viewport_rect().size
	
func _physics_process(delta):
	var input_vector = Vector2.ZERO;
	input_vector.x = Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left");
	input_vector.y = Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up");
	if(input_vector != Vector2.ZERO):
		velocity = input_vector;
	else:
		velocity = Vector2.ZERO	
	
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
		
	position.x = clamp(position.x, 0, borderLimit.x)
	position.y = clamp(position.y, 0, borderLimit.y)
	move_and_collide(velocity);
	
		
		
