extends Node

const MAX_SPEED = 200
const ACCELERATION = 700
const FRICTION = 700

func move_main_character(character, delta):  # Recibir las referencias como argumentos
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		character.velocity = character.velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta);
	else:
		character.velocity = character.velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	character.move_and_slide()
	
func animate_main_character(character, player_sprite):
	if character.velocity.x != 0:
		if character.velocity.x < 0:
			player_sprite.animation = "left"
			player_sprite.play("left")
		else:
			player_sprite.animation = "right"
			player_sprite.play("right")
	elif character.velocity.y != 0:
		if character.velocity.y < 0:
			player_sprite.animation = "up"
			player_sprite.play("up")
		else:
			player_sprite.animation = "down"
			player_sprite.play("down")
	else:
		player_sprite.animation = "idle"
		player_sprite.play("idle")

