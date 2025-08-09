class_name EquipmentSlots extends Resource

@export var headgear: PackedScene
@export var chest: PackedScene
@export var pants: PackedScene
@export var boots: PackedScene
@export var weapon: PackedScene
@export var trinkets: PackedScene

func list() -> Array[PackedScene]:
	var list: Array[PackedScene] = []
	if headgear != null: list.append(headgear)
	if chest != null: list.append(chest)
	if pants != null: list.append(pants)
	if boots != null: list.append(boots)
	if weapon != null: list.append(weapon)
	if trinkets != null: list.append(trinkets)
	return list
