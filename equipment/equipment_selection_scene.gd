extends Node2D

const CARD_COUNT = 3
var equipment_on_cards: Array[PackedScene] = []

func pick_different(input: Array[PackedScene], count: int) -> Array[PackedScene]:
	assert(input.size() >= count)
	
	var out: Array[PackedScene] = []
	while true:
		var pick = EquipmentRegisty.all.pick_random()
		if (out.has(pick)): continue
		out.append(pick)
		if out.size() == 3: break
	return out

func _ready() -> void:
	var player1: Player = PlayerState.player1_scene.instantiate()
	player1.equipment_slots = PlayerState.player1_equipment
	$PlayerPos1.add_child(player1)
	$PlayerStatsView1.title = player1.fullname
	#$PlayerStatsView1.player_description = player1.description
	$PlayerStatsView1.stats = PlayerState.player1_equipment.list().reduce(
		func (stats, equipment):
			stats.apply_stats(equipment.instantiate().stats)
			return stats,
		EquipmentStats.new(),
	)
	
	var player2: Player = PlayerState.player2_scene.instantiate()
	player2.equipment_slots = PlayerState.player2_equipment
	player2.flip()
	$PlayerPos2.add_child(player2)
	$PlayerStatsView2.title = player2.fullname
	#$PlayerStatsView2.player_description = player2.description
	$PlayerStatsView2.stats = PlayerState.player2_equipment.list().reduce(
		func (stats, equipment):
			stats.apply_stats(equipment.instantiate().stats)
			return stats,
		EquipmentStats.new(),
	)
	
	equipment_on_cards = pick_different(EquipmentRegisty.all, CARD_COUNT)
	
	var card1: Card = load("res://cards/card.tscn").instantiate()
	card1.equipment_scene = equipment_on_cards[0]
	card1.set_pos_index(0)
	$CardPos1.add_child(card1)
	
	var card2: Card = load("res://cards/card.tscn").instantiate()
	card2.equipment_scene = equipment_on_cards[1]
	card2.set_pos_index(1)
	$CardPos2.add_child(card2)
	
	var card3: Card = load("res://cards/card.tscn").instantiate()
	card3.equipment_scene = equipment_on_cards[2]
	card3.set_pos_index(2)
	$CardPos3.add_child(card3)

func next() -> void:
	var card1 = $PlayerPos1.card
	if card1 != null:
		PlayerState.player1_equipment.equip(card1.equipment_scene)
		
	var card2 = $PlayerPos2.card
	if card2 != null:
		PlayerState.player2_equipment.equip(card2.equipment_scene)
		
	get_tree().change_scene_to_file("res://figth_scene.tscn")
