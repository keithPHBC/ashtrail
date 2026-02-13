extends CharacterBody2D

const StatsClass = preload("res://scripts/resources/stats.gd")
var stats: Resource

const GRAVITY: float = 1200.0
const ACCELERATION: float = 0.2
const FRICTION: float = 0.15
const JUMP_CUT_MULTIPLIER: float = 0.4
const ATTACK_DURATION: float = 0.2
const ATTACK_COOLDOWN: float = 0.35

var _facing_right: bool = true
var _attack_timer: float = 0.0
var _attack_cooldown_timer: float = 0.0

@onready var attack_area: Area2D = $AttackArea
@onready var attack_shape: CollisionShape2D = $AttackArea/AttackShape
@onready var attack_sprite: Sprite2D = $AttackArea/AttackSprite

func _ready() -> void:
	stats = StatsClass.new()
	stats.reset()

	# Placeholder visual: green rectangle
	var img := Image.create(24, 40, false, Image.FORMAT_RGBA8)
	img.fill(Color(0.2, 0.8, 0.3))
	var tex := ImageTexture.create_from_image(img)
	$Sprite2D.texture = tex

	# Placeholder attack visual: red rectangle (hidden by default)
	var atk_img := Image.create(28, 24, false, Image.FORMAT_RGBA8)
	atk_img.fill(Color(0.9, 0.2, 0.2, 0.7))
	attack_sprite.texture = ImageTexture.create_from_image(atk_img)
	attack_sprite.visible = false

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

	# Jump (variable height: release early for short hop)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -stats.jump_force
	if Input.is_action_just_released("jump") and velocity.y < 0.0:
		velocity.y *= JUMP_CUT_MULTIPLIER

	# Facing direction
	if input_dir != 0.0:
		_facing_right = input_dir > 0.0
		$Sprite2D.flip_h = not _facing_right
		attack_area.position.x = 26.0 if _facing_right else -26.0

	# Attack
	_attack_cooldown_timer = maxf(0.0, _attack_cooldown_timer - delta)
	if _attack_timer > 0.0:
		_attack_timer -= delta
		if _attack_timer <= 0.0:
			_end_attack()
	if Input.is_action_just_pressed("attack") and _attack_cooldown_timer <= 0.0 and _attack_timer <= 0.0:
		_start_attack()

	move_and_slide()

func _start_attack() -> void:
	_attack_timer = ATTACK_DURATION
	attack_shape.disabled = false
	attack_sprite.visible = true
	_hit_enemies()

func _end_attack() -> void:
	attack_shape.disabled = true
	attack_sprite.visible = false
	_attack_cooldown_timer = ATTACK_COOLDOWN

func _hit_enemies() -> void:
	for body in attack_area.get_overlapping_bodies():
		if body.has_method("take_damage"):
			body.take_damage(stats.attack_damage)
