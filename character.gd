extends Node2D
class_name Character

@export var is_player: bool = false
@export var current_hp: int = 25
@export var max_hp: int = 25

@export var combat_action: Array
@export var opponent: Node

@onready var health_bar: ProgressBar = %HealthBar
@onready var health_text: Label = %HealthText

func _ready() -> void:
	health_bar.max_value = max_hp

func take_damage(damage: int) -> void:
	current_hp -= damage
	_update_health_bar()

	if current_hp <= 0:
		queue_free()

func heal(amount: int) -> void:
	current_hp += amount
	_update_health_bar()

	if current_hp > max_hp:
		current_hp = max_hp

func _update_health_bar() -> void:
	health_bar.value = current_hp
	health_text.text = str(current_hp, " / ", max_hp)
