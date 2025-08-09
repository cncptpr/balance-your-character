extends Equipment

func use() -> EquipmentStats:
	print("Fireballlll")
	$AnimationPlayer.play("attack_fireball")
	return stats
