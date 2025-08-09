extends Equipment

func use() -> EquipmentStats:
	print("Sword used")
	$AnimationPlayer.play("attack_sword")
	return stats
