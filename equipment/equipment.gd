class_name Equipment extends Node2D

@export var stats: EquipmentStats

@export var title: String
@export var desciption: String

func use() -> EquipmentStats:
	return stats
	
func defend() -> EquipmentStats:
	return stats
