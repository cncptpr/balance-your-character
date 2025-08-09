extends Node2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass


func _on_button_pressed_main_menu() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
	print("pressed return to menu")
	pass
