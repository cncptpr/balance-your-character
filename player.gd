class_name Player extends Node2D

signal deal_damage(damage: float)
signal rip()

@export var fullname: String = "Noname"
var surnames: Array[String] = ["Alexander", "Herbert", "Paul", "Jim", "Robert", "George", "Mia", "Lucy"]
var lastnames: Array[String] = ["Giant", "Noisy", "Drinker", "Frightening", "Wandering Vending Machine"]


@export var max_health: float = 100
var health: float = max_health

@export var base_stats: EquipmentStats
var attack_stats: EquipmentStats

@export var inventory_node: NodePath
@export var equipmentSlots: EquipmentSlots

@onready var animationTree : AnimationTree = $Appearance/AnimationTree
@onready var animationStateMachine: AnimationNodeStateMachinePlayback = animationTree["parameters/playback"]

func _ready() -> void:
	fullname = generate_name()
	setAppearance()
	
	animationTree.active = true
	animationStateMachine.travel("Idle")
	for equipmentScene in equipmentSlots.list():
		var equipment = equipmentScene.instantiate()
		if equipment is not Equipment:
			continue
		$Appearance/Sprite2D/Inventory.add_child(equipment)

func flip():
	$Appearance.scale.x = -1

func generate_name():
	return surnames[randi_range(0,7)] + " the " + lastnames[randi_range(0,4)]

func setAppearance():
	var type: int = randi_range(0,2)
	if type == 0:
		$Appearance/Sprite2D.texture = load("res://assets/Players/CL_Tank.webp")
		$Appearance/Sprite2D/arm.texture = load("res://assets/Players/CL_TankArm.webp")
		$Appearance/Sprite2D/arm.offset = Vector2(0, 0)
	if type == 1:
		$Appearance/Sprite2D.texture = load("res://assets/Players/CL_Mage.png")
		$Appearance/Sprite2D/arm.texture = load("res://assets/Players/CL_MageArm.png")
		$Appearance/Sprite2D/arm.offset = Vector2(-156, -136)
	if type ==2:
		$Appearance/Sprite2D.texture = load("res://assets/Players/CL_Fighter.png")
		$Appearance/Sprite2D/arm.texture = load("res://assets/Players/CL_FighterArm.png")
		$Appearance/Sprite2D/arm.offset = Vector2(-100, -160)

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
	
	for node in $Appearance/Sprite2D/Inventory.get_children():
		if node is Equipment:
			var stats = node.use()
			attack_stats.apply_stats(stats)
	attack_stats.apply_mods()
	
	animationStateMachine.travel("Attack") 
	$WarmupTimer.start(attack_stats.warmup)

func attack():
	if health == 0: return
	print(name, ": Attacking with ", attack_stats.damage, " Damage")
	
	deal_damage.emit(attack_stats.damage)
	
	$CooldownTimer.start(attack_stats.cooldown)

func take_damage(damage: int):
	var defend_stats = EquipmentStats.new()
	defend_stats.apply_stats(base_stats)
	
	for node in $Appearance/Sprite2D/Inventory.get_children():
		if node is Equipment:
			var stats = node.defend()
			defend_stats.apply_stats(stats)
	defend_stats.apply_mods()
	
	var damage_taken = damage * (1 - defend_stats.blocked_percent) - defend_stats.defence
	
	print(name, ": Got attacked with ", damage, " damage, ",
		defend_stats.defence," defended, ", 
		damage_taken, " taken.")
	
	health = move_toward(health, 0, damage_taken)
	$LifeCounter.text = str(round(health)) + "/" + str(round(max_health))
	
	if health == 0: died()

func died():
	print(name, ": RIP")
	rip.emit()
	animationStateMachine.travel("Rip")
