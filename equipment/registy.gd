extends Node2D

const sword = "res://equipment/sword/sword.tscn"
const bucket = "res://equipment/bucket/bucket.tscn"
const plank = "res://equipment/plank/plank.tscn"
const fireball = "res://equipment/fireball/fireball.tscn"

var all: Array[PackedScene] = [
	load(sword), 
	load(bucket), 
	load(plank), 
	load(fireball),
]:
	set(_new): assert(false)

var weapons: Array[PackedScene] = [
	load(sword), 
	load(fireball),
]:
	set(_new): assert(false)
	
var armor: Array[PackedScene] = [
	load(plank), 
]:
	set(_new): assert(false)
