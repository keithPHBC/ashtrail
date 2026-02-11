extends CharacterBody2D

const StatsClass = preload("res://scripts/resources/stats.gd")
var stats: Resource

const GRAVITY: float = 1200.0
const ACCELERATION: float = 0.2
const FRICTION: float = 0.15

func _ready() -> void:
	# Create default stats (will be injectable later via .tres)
	stats = StatsClass.new()
	stats.reset()

	# Placeholder visual: green rectangle
	var img := Image.create(24, 40, false, Image.FORMAT_RGBA8)
	img.fill(Color(0.2, 0.8, 0.3))
	var tex := ImageTexture.create_from_image(img)
	$Sprite2D.texture = tex

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Horizontal movement
	var input_dir := Input.get_axis("move_left", "move_right")
	if input_dir != 0.0:
		velocity.x = lerp(velocity.x, input_dir * stats.speed, ACCELERATION)
	else:
		velocity.x = lerp(velocity.x, 0.0, FRICTION)

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -stats.jump_force

	# Flip sprite to face movement direction
	if input_dir != 0.0:
		$Sprite2D.flip_h = input_dir < 0.0

	move_and_slide()
