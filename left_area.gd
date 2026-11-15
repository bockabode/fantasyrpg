extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("LEFT DETECTED: ", body.name)

	if body.name == "Player":
		if $"../Background2".visible:
			$"../Background2".hide()
			$"../Background1".show()
			body.global_position.x = 1072
