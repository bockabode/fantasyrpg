extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		# Safely look for the spawn point node
		var spawn_point = get_node_or_null("%SpawnPoint")
		
		if spawn_point:
			body.global_position = spawn_point.global_position
		else:
			print("Error: Could not find SpawnPoint node in the scene!")
