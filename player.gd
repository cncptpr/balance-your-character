extends Node2D

signal deal_damage(damage: int)
signal rip()

const MAX_HEALTH: int = 100
var health: int = MAX_HEALTH

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func start_figth():
	print(name, ": Start Figth")
	$RoundTimer.start()

func stop_figth():
	print(name, ": Stopped Figthing")
	$RoundTimer.stop()

func attack():
	if health == 0: return
	
	for node in $Inventory.get_children():
		if node is Equipment:
			node.use(apply_equipment_stats)

func apply_equipment_stats(stats: EquipmentStats):
	deal_damage.emit(stats.damage) #emit ist signal
	
func take_damage(damage: int):
	print(name, ": Took damage ", damage)
	health = move_toward(health, 0, damage)
	if health == 0:
		print(name, ": RIP")
		rip.emit()
		self.scale.y = -1
	$Label.text = str(health) + "/" + str(MAX_HEALTH)
