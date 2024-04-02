extends Node
class_name TurnManager

@export var player_character: Character
@export var enemy_character: Character
@export var start_turn_delay: float = 0.5
@export var next_turn_delay: float = 1.0

signal character_begin_turn(character: Character)
signal character_end_turn(character: Character)

var current_character: Character
var game_over: bool = false

func _ready() -> void:
	await get_tree().create_timer(start_turn_delay).timeout
	begin_next_turn()

func begin_next_turn() -> void:
	if current_character == player_character:
		current_character = enemy_character
	elif current_character == enemy_character:
		current_character = player_character
	else:
		current_character = player_character

	character_begin_turn.emit(current_character)

func end_current_turn() -> void:
	character_end_turn.emit(current_character)

	await get_tree().create_timer(next_turn_delay).timeout

	if not game_over:
		begin_next_turn()

func character_died(character: Character) -> void:
	game_over = true

	if character.is_player:
		print("Game Over!")
	else:
		print("You Win!")
