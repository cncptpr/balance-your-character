extends Node2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass


func _on_button_pressed_fight() -> void:
	if Input.is_action_pressed("skip_hack"):
		print(">>> skip_hack")
	get_tree().change_scene_to_file("res://figth_scene.tscn")
	print("pressed fight button")
