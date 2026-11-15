extends Area2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$"../Background1".hide()
		$"../Background2".show()
