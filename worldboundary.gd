extends Area2D

func _on_body_entered(body: Node2D) -> void:
	# If you did this, it moves the boundary:
	# position = Vector2(position.x, 450)
	
	# Because you use "body.", it moves the player who touched it:
	if body.name == "Player":
		body.position = Vector2(body.position.x, -300)
