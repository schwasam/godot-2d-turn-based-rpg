extends Button
class_name CombatActionButton

var combat_action: CombatAction

@onready var turn_manager: TurnManager = $"/root/BattleScene"

func _on_pressed() -> void:
	turn_manager.current_character.cast_combat_action(combat_action)
