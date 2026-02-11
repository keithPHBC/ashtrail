extends Node2D

# Builds a simple test level using StaticBody2D platforms.
# This avoids TileMap complexity for initial movement testing.
# Will be replaced with proper TileMap in LEVEL-1.

func _ready() -> void:
	_create_platform(Vector2(320, 360), Vector2(800, 20), Color(0.4, 0.4, 0.5))  # Floor
	_create_platform(Vector2(150, 280), Vector2(120, 16), Color(0.5, 0.4, 0.4))  # Left platform
	_create_platform(Vector2(400, 240), Vector2(150, 16), Color(0.5, 0.4, 0.4))  # Middle platform
	_create_platform(Vector2(580, 180), Vector2(120, 16), Color(0.5, 0.4, 0.4))  # Right platform

func _create_platform(pos: Vector2, size: Vector2, color: Color) -> void:
	var body := StaticBody2D.new()
	body.position = pos

	var col := CollisionShape2D.new()
	var shape := RectangleShape2D.new()
	shape.size = size
	col.shape = shape
	body.add_child(col)

	var sprite := Sprite2D.new()
	var img := Image.create(int(size.x), int(size.y), false, Image.FORMAT_RGBA8)
	img.fill(color)
	sprite.texture = ImageTexture.create_from_image(img)
	body.add_child(sprite)

	add_child(body)
