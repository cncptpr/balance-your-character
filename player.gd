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
@export var equipment_slots: EquipmentSlots

@onready var animationTree : AnimationTree = $Appearance/AnimationTree
@onready var animationStateMachine: AnimationNodeStateMachinePlayback = animationTree["parameters/playback"]

func _ready() -> void:
	fullname = generate_name()
	animationTree.active = true
	animationStateMachine.travel("Idle")
	
	if equipment_slots == null: return
	var collected_stats = EquipmentStats.new()
	collected_stats.apply_stats(base_stats)
	for equipmentScene in equipment_slots.list():
		var equipment = equipmentScene.instantiate()
		if equipment is not Equipment:
			continue
		$Appearance/Sprite2D/Inventory.add_child(equipment)
		if !EquipmentRegisty.weapons.has(equipmentScene):
			equipment.visible = false
		collected_stats.apply_stats(equipment.defend())
	collected_stats.apply_mods()
	max_health = collected_stats.health
	health = max_health
	
	$LifeCounter.text = str(round(health)) + "/" + str(round(max_health))

func flip():
	$Appearance.scale.x = -1

func generate_name():
	return surnames[randi_range(0,7)] + " the " + lastnames[randi_range(0,4)]

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
	
	var damage_taken = damage * (1 - max(defend_stats.blocked_percent, 0)) - max(defend_stats.defence, 0)
	damage_taken = max(damage_taken, 0)
	
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
