class_name FightScene extends Node2D

var player1: Player
var player2: Player

var button_message: String
var score: int

func _ready() -> void:
	$GameEnd.visible = false
	if player1 == null:
		assert(PlayerState.player1_scene != null)
		player1 = PlayerState.player1_scene.instantiate()
		player1.equipment_slots = PlayerState.player1_equipment
		
	if player2 == null:
		assert(PlayerState.player2_scene != null)
		player2 = PlayerState.player2_scene.instantiate()
		player2.equipment_slots = PlayerState.player2_equipment
	
	add_child(player1)
	player1.deal_damage.connect(player2.take_damage)
	player1.rip.connect(player1_died)
	player1.transform.origin = Vector2(381.0, 500.0)
	
	add_child(player2)
	player2.deal_damage.connect(player1.take_damage)
	player2.rip.connect(player2_died)
	player2.transform.origin = Vector2(867.0, 500.0)
	
	player2.flip()
	start_figth()

func start_figth() -> void:
	print("Scene: Start Figth")
	player1.start_figth()
	player2.start_figth()

func tick_round() -> void:
	print("Attack!!!! ⚔️")


func player1_died() -> void:
	player_won(player1.fullname + " has won")


func player2_died() -> void:
	player_won(player2.fullname + " has won")
	
func player_won(label_message: String):
	player1.stop_figth()
	player2.stop_figth()


	score = (100-abs((player1.health*100/player1.max_health)-(player2.health*100/player2.max_health)))
	Globalvar.GlobalScore += score
	print(">> Global Score: " + str(Globalvar.GlobalScore))
	
	button_message = "try again"
	button_message = "next fight"
	$GameEnd/wintext.text = label_message
	$GameEnd/start_balance/Button.text = button_message
	$GameEnd.visible = true
	$GameEnd/Label.text = "Score: " + str(score)


func _on_button_pressed_next_balance() -> void:
	get_tree().change_scene_to_file("res://equipment/equipment_selection_scene.tscn")
	print("pressed next button")

func _on_button_mouse_touched_button_again() -> void:
	$ButtonSound.play()
