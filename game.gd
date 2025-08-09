extends Node2D

@export var currentScene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.add_child(currentScene.instantiate())
	print("game startup")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
