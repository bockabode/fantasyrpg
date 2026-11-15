extends Sprite2D

@export var bob_height: float = 12.0
@export var bob_speed: float = 0.6

func _ready() -> void:
	var start_y := position.y
	var tween := create_tween().set_loops()
	
	tween.tween_property(self, "position:y", start_y - bob_height, bob_speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position:y", start_y, bob_speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
