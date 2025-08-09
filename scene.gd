extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_figth() -> void:
	print("Scene: Start Figth")
	$Player1.start_figth()
	$Player2.start_figth()
	$GameStart.queue_free()

func tick_round() -> void:
	print("Attack!!!! ⚔️")


func _on_player_1_rip() -> void:
	player_won("Right has won")


func _on_player_2_rip() -> void:
	player_won("Left has won")
	
func player_won(message: String):
	$GameEnd/ColorRect/Label.text = message
	$GameEnd.visible = true
	$Player1.stop_figth()
	$Player2.stop_figth()
