class_name Stats
extends Resource

@export var max_hp: int = 100
@export var current_hp: int = 100
@export var speed: float = 300.0
@export var jump_force: float = 600.0
@export var attack_damage: int = 25

signal hp_changed(new_hp: int)
signal hp_depleted

func take_damage(damage: int) -> void:
	current_hp = maxi(0, current_hp - damage)
	hp_changed.emit(current_hp)
	if current_hp == 0:
		hp_depleted.emit()

func heal(amount: int) -> void:
	current_hp = mini(max_hp, current_hp + amount)
	hp_changed.emit(current_hp)

func reset() -> void:
	current_hp = max_hp
