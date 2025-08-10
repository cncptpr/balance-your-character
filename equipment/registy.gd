extends Node2D

# Weapons
var cyptonite_sword = load("res://equipment/cryptonite_sword/cryptonite_sword.tscn")
var mytic_sword = load("res://equipment/mytic_sword/mytic_sword.tscn")
var fire_ball = load("res://equipment/fireball/fireball.tscn")

# Head Wear
var used_wizzard_head = load("res://equipment/used_wizzard_head/used_wizzard_head.tscn")
var carneval_wizzard_head = load("res://equipment/carneval_wizzard_head/carneval_wizzard_head.tscn")

# Chest
var inverted_thorns_chestplate = load("res://equipment/inverted_thorns_chestplate/inverted_thorns_chestplate.tscn")
var heavy_chestplate = load("res://equipment/heavy_chestplate/heavy_chestplate.tscn")

# pants
var hawk_leather_pants = load("res://equipment/hawk_leather_pants/hawk_leather_pants.tscn")

# boots
var lightning_coated_boots = load("res://equipment/lightning_coated_boots/lightning_coated_boots.tscn")

# trinkets
var health_potion = load("res://equipment/health_potion/health_potion.tscn")

var weapons: Array[PackedScene] = [
	cyptonite_sword,
	mytic_sword,
	fire_ball,
]:
	set(_new): assert(false)
	
var headgear: Array[PackedScene] = [
	used_wizzard_head,
	carneval_wizzard_head,
]:
	set(_new): assert(false)
	
var chest: Array[PackedScene] = [
	inverted_thorns_chestplate,
	heavy_chestplate,
]:
	set(_new): assert(false)
	
var pants: Array[PackedScene] = [
	hawk_leather_pants,
]:
	set(_new): assert(false)
	
var boots: Array[PackedScene] = [
	lightning_coated_boots
]:
	set(_new): assert(false)
	
var trinkets: Array[PackedScene] = [
	health_potion,
]:
	set(_new): assert(false)

var all: Array[PackedScene] = []

func _ready() -> void:
	all.append_array(weapons)
	all.append_array(headgear)
	all.append_array(chest)
	all.append_array(pants)
	all.append_array(boots)
	all.append_array(trinkets)
