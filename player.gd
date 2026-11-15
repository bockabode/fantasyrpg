extends CharacterBody2D

const speed = 400
const jump_velocity = -450
const gravity = 980

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * speed
	
	if direction < 0:
		get_node("Sprite2D").flip_h = true
	elif direction > 0:
		get_node("Sprite2D").flip_h = false
	
	move_and_slide()
