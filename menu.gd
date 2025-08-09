extends Node2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass


func _on_button_pressed_start() -> void:
	get_tree().change_scene_to_file("res://balance_screen.tscn")
	print("pressed start button")
	pass

func _on_button_pressed_credits() -> void:
	get_tree().change_scene_to_file("res://credits.tscn")
	print("pressed credits button")
	pass


func _on_button_pressed_end() -> void:
	get_tree().quit()
	pass
