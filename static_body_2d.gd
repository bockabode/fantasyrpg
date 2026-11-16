@tool
extends StaticBody2D

# Point this to your level Sprite2D node
@export var level_sprite: Sprite2D
# Pixels with alpha below this value (0.0 to 1.0) will be completely ignored
@export_range(0.0, 1.0) var alpha_threshold: float = 0.8
@export var simplification: float = 3.0

@export var generate_now: bool = false:
	set(value):
		if value and level_sprite and level_sprite.texture:
			_build_collisions()
		generate_now = false

func _build_collisions() -> void:
	# Clear any previously generated polygons
	for child in get_children():
		if child is CollisionPolygon2D:
			child.queue_free()

	var image := level_sprite.texture.get_image()
	var bitmap := BitMap.new()
	# Ignores all pixels fainter than alpha_threshold
	bitmap.create_from_image_alpha(image, alpha_threshold)

	var polygons := bitmap.opaque_to_polygons(Rect2i(Vector2i.ZERO, image.get_size()), simplification)
	var offset := -image.get_size() / 2.0 if level_sprite.centered else Vector2.ZERO

	for poly in polygons:
		var col_poly := CollisionPolygon2D.new()
		var shifted_poly := PackedVector2Array()
		for point in poly:
			shifted_poly.append(point + offset)
		col_poly.polygon = shifted_poly
		add_child(col_poly)
		col_poly.owner = get_tree().edited_scene_root
