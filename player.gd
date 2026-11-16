extends CharacterBody2D

const speed = 300
const jump_velocity = -450
const gravity = 980
const MAX_FALL_SPEED = 900.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera: Camera2D = $Camera2D

var respawn_pos: Vector2
var start_screen_pos: Vector2
var is_respawning: bool = false

var respawn_x: float = 10.0
var respawn_top_y: float = -480.0

func _ready() -> void:
	respawn_pos = global_position
	# Wait one physics frame so Camera2D settles into its starting screen position
	await get_tree().physics_frame
	start_screen_pos = camera.get_screen_center_position()
	
func _physics_process(delta: float) -> void:
	if is_respawning:
		return
		
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = minf(velocity.y, MAX_FALL_SPEED)
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	if direction < 0:
		animated_sprite.flip_h = true
	elif direction > 0:
		animated_sprite.flip_h = false
		
	if direction != 0:
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")
	
	move_and_slide()

func respawn_from_top() -> void:
	if is_respawning:
		return
		
	is_respawning = true
	velocity = Vector2.ZERO
	visible = false
	
	var cam_start_pos := camera.get_screen_center_position()
	var horizontal_scroll := absf(cam_start_pos.x - start_screen_pos.x)
		
	if horizontal_scroll > 20.0:
		var was_smoothing := camera.position_smoothing_enabled
		camera.position_smoothing_enabled = false
		
		camera.top_level = true
		camera.global_position = cam_start_pos
		
		# Longer duration + EASE_OUT makes the slowdown very noticeable
		var duration := clampf(horizontal_scroll / 300.0, 0.8, 2.2)
		var tween := create_tween()
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(camera, "global_position", start_screen_pos, duration)
		await tween.finished
		
		camera.position_smoothing_enabled = was_smoothing
	else:
		await get_tree().create_timer(0.4).timeout

	global_position = Vector2(respawn_x, respawn_top_y)
	camera.top_level = false
	camera.position = Vector2.ZERO
	
	visible = true
	is_respawning = false
