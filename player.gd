extends Node2D

signal deal_damage(damage: int)

const MAX_HEALTH: int = 100
var health: int = MAX_HEALTH

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func attack():
	deal_damage.emit(randf_range(5, 10))
	print(name, ": Attacking")

func take_damage(damage: int):
	print(name, ": Took damage ", damage)
	health = move_toward(health, 0, damage)
	if (health == 0):
		$Sprite2D.flip_v = true
	$Label.text = str(health) + "/" + str(MAX_HEALTH)
