extends Node2D

signal deal_damage(damage: float)
signal rip()

<<<<<<< HEAD
@export var max_health: float = 100
var health: float = max_health
||||||| parent of 0b834f8 (setup animation tree)
=======
@onready var animationTree : AnimationTree = $Appearance/AnimationTree
@onready var animationStateMachine: AnimationNodeStateMachinePlayback = animationTree["parameters/playback"]
>>>>>>> 0b834f8 (setup animation tree)

@export var base_stats: EquipmentStats
var attack_stats: EquipmentStats

<<<<<<< HEAD
||||||| parent of 0b834f8 (setup animation tree)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
=======

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animationTree.active = true
	animationStateMachine.travel("Idle")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
>>>>>>> 0b834f8 (setup animation tree)
func start_figth():
	print(name, ": Start Figth")
	prepare_attack()

func stop_figth():
	$WarmupTimer.paused = true
	$CooldownTimer.paused = true
	print(name, ": Stopped Figthing")

func prepare_attack() -> void:
	if health == 0: return
	
	attack_stats = EquipmentStats.new()
	attack_stats.apply_stats(base_stats)
	
	print(name, ": Using Equipment")
	
	for node in $Inventory.get_children():
		if node is Equipment:
			var stats = node.use()
			attack_stats.apply_stats(stats)
	attack_stats.apply_mods()
	
	$WarmupTimer.start(attack_stats.warmup)

func attack():
	if health == 0: return
<<<<<<< HEAD
	print(name, ": Attacking with ", attack_stats.damage, " Damage")
	
	deal_damage.emit(attack_stats.damage)
	
	$CooldownTimer.start(attack_stats.cooldown)
	
||||||| parent of 0b834f8 (setup animation tree)
	
=======
	animationStateMachine.travel("Attack") 
>>>>>>> 0b834f8 (setup animation tree)
	var damage = int(randf_range(5, 10))
	deal_damage.emit(damage)
	print(name, ": Attacking with damage ", damage)

func take_damage(damage: int):
	var defend_stats = EquipmentStats.new()
	defend_stats.apply_stats(base_stats)
	
	for node in $Inventory.get_children():
		if node is Equipment:
			var stats = node.defend()
			defend_stats.apply_stats(stats)
	defend_stats.apply_mods()
	
	var damage_taken = damage * (1 - defend_stats.blocked_percent) - defend_stats.defence
	
	print(name, ": Got attacked with ", damage, " damage, ",
		defend_stats.defence," defended, ", 
		damage_taken, " taken.")
	
	health = move_toward(health, 0, damage_taken)
	$Label.text = str(round(health)) + "/" + str(round(max_health))
	
	if health == 0: died()

func died():
	print(name, ": RIP")
	rip.emit()
	$Appearance/Sprite2D.flip_v = true
	$Label.text = str(health) + "/" + str(MAX_HEALTH)
