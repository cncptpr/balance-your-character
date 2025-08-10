@tool
class_name PlayerStatsView extends Node

@export var stats: EquipmentStats:
	set(value):
		stats = value
		value.apply_mods()
		$DamageLabel/StatsBar.stat = value.damage
		$DefenceLabel/StatsBar.stat = value.defence
		$SpeedLabel/StatsBar.stat = -(value.cooldown + value.warmup)
		$BlockLabel/StatsBar.stat = value.blocked_percent

@export var title: String:
	set(value):
		$StatsViewTitle.text = value
		value = title

@export var player_description: String:
	set(value):
		$Description.text = value
		value = title

		
func _ready() -> void:
	set_process(true)
