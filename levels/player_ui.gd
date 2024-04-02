extends VBoxContainer

@export var buttons: Array[CombatActionButton]

@onready var turn_manager: TurnManager = $"/root/BattleScene"

func _ready() -> void:
	turn_manager.character_begin_turn.connect(_on_character_begin_turn)
	turn_manager.character_end_turn.connect(_on_character_end_turn)

func _on_character_begin_turn(character: Character) -> void:
	visible = character.is_player

	if character.is_player:
		_display_combat_actions(character.combat_actions)

func _on_character_end_turn(character: Character) -> void:
	visible = false

func _display_combat_actions(combat_actions: Array[CombatAction]) -> void:
	for i in len(buttons):
		var button = buttons[i]

		if i < len(combat_actions):
			button.visible = true
			button.text = combat_actions[i].display_name
			button.combat_action = combat_actions[i]
		else:
			button.visible = false
