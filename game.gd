extends Node2D

@export var figthScene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.add_child(figthScene.instantiate())
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
