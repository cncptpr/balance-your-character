extends Node2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass


func _on_button_pressed_fight() -> void:
	get_tree().change_scene_to_file("res://figth_scene.tscn")
	print("pressed fight button")
	pass
