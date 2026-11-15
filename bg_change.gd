extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and $"../Background1".visible:
		$"../Background1".hide()
		$"../Background2".show()
		
		$"../LeftWall/CollisionShape2D".set_deferred("disabled", true)
		body.global_position.x = 80
