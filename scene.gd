extends Node2D

@export var player1Scene: PackedScene
@export var player1EquipmentSlots: EquipmentSlots
@export var player1: Player

@export var player2Scene: PackedScene
@export var player2EquipmentSlots: EquipmentSlots
@export var player2: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if player1 == null:
		assert(player1Scene != null)
		player1 = player1Scene.instantiate()
		player1.equipmentSlots = player1EquipmentSlots
		
	if player2 == null:
		assert(player2Scene != null)
		player2 = player2Scene.instantiate()
		player2.equipmentSlots = player2EquipmentSlots
	
	add_child(player1)
	player1.deal_damage.connect(player2.take_damage)
	player1.rip.connect(player1_died)
	player1.transform.origin = Vector2(381.0, 500.0)
	
	add_child(player2)
	player2.deal_damage.connect(player1.take_damage)
	player2.rip.connect(player2_died)
	player2.transform.origin = Vector2(867.0, 500.0)
	player2.flip()

func start_figth() -> void:
	print("Scene: Start Figth")
	player1.start_figth()
	player2.start_figth()
	$GameStart.queue_free()

func tick_round() -> void:
	print("Attack!!!! ⚔️")


func player1_died() -> void:
	player_won("Right has won")


func player2_died() -> void:
	player_won("Left has won")
	
func player_won(message: String):
	$GameEnd/ColorRect/Label.text = message
	$GameEnd.visible = true
	player1.stop_figth()
	player2.stop_figth()
