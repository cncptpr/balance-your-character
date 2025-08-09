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

func equip(equipment: PackedScene):
	if (EquipmentRegisty.headgear.has(equipment)):
		headgear = equipment
	elif (EquipmentRegisty.chest.has(equipment)):
		chest = equipment
	elif (EquipmentRegisty.pants.has(equipment)):
		pants = equipment
	elif (EquipmentRegisty.boots.has(equipment)):
		boots = equipment
	elif (EquipmentRegisty.weapons.has(equipment)):
		weapon = equipment
	elif (EquipmentRegisty.trinkets.has(equipment)):
		trinkets = equipment
	else:
		assert(false, "equipment muss fit in one of the categories")
