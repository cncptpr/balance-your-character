extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_figth()
	$GameEnd.visible = false
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
#etwas, dass das startet wenn scene erstellt wird
func start_figth() -> void:
	print("Scene: Start Figth")
	$Player1.start_figth()
	$Player2.start_figth()

func tick_round() -> void:
	print("Attack!!!! ⚔️")


func _on_player_1_rip() -> void:
	player_won("Right has won")


func _on_player_2_rip() -> void:
	player_won("Left has won")
	
func player_won(label_message: String):
	$Player1.stop_figth()
	$Player2.stop_figth()
	pass
	var button_message: String
	button_message = "try again"
	button_message = "next fight"
	$GameEnd/ColorRect/Label.text = label_message
	$GameEnd/start_balance/Button.text = button_message
	$GameEnd.visible = true


func _on_button_pressed_next_balance() -> void:
	get_tree().change_scene_to_file("res://balance_screen.tscn")
	print("pressed next button")
	pass
