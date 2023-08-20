extends Node

const MAX_SPEED = 200

func move_main_character(character, delta, player_sprite):  # Recibir las referencias como argumentos
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	if input_vector != Vector2.ZERO:
		character.velocity = input_vector
	else:
		character.velocity = Vector2.ZERO
		
	character.move_and_collide(character.velocity * delta * MAX_SPEED)
	
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

