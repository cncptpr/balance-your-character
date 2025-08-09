class_name Equipment extends Node2D

@export var stats: EquipmentStats

func use(apply: Callable):
	apply.call(stats)
