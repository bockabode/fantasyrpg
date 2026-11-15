extends Area2D

@export var win_screen: CanvasLayer

func _on_body_entered(body: Node2D) -> void:
	# Check if the object entering the goal is the Player
	if body is CharacterBody2D:
		win_screen.show()
		# Freeze the player so they can't keep running or falling after winning
		body.set_physics_process(false)
