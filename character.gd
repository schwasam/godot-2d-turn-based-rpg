extends Node2D
class_name Character

@export var is_player: bool = false
@export var visual: Texture2D
@export var flip_visual: bool = true

@export var current_hp: int = 25
@export var max_hp: int = 25

@export var combat_action: Array
@export var opponent: Node

@onready var turn_manager: TurnManager = $"/root/BattleScene"
@onready var health_bar: ProgressBar = %HealthBar
@onready var health_text: Label = %HealthText

func _ready() -> void:
	%Sprite.texture = visual
	%Sprite.flip_h = flip_visual

	turn_manager.character_begin_turn.connect(_on_character_begin_turn)
	health_bar.max_value = max_hp

func take_damage(damage: int) -> void:
	current_hp -= damage
	_update_health_bar()

	if current_hp <= 0:
		turn_manager.character_died(self)
		queue_free()

func heal(amount: int) -> void:
	current_hp += amount
	_update_health_bar()

	if current_hp > max_hp:
		current_hp = max_hp

func _update_health_bar() -> void:
	health_bar.value = current_hp
	health_text.text = str(current_hp, " / ", max_hp)

func _on_character_begin_turn(character: Character) -> void:
	pass
