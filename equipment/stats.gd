class_name EquipmentStats extends Resource

@export var damage: float = 0
@export var damage_mod: float = 1.0

@export var cooldown: float = 0.0
@export var cooldown_mod: float = 1.0

@export var warmup: float = 0.0
@export var warmup_mod: float = 1.0

@export var defence: float = 0.0
@export var defence_mod: float = 1.0

@export var blocked_percent: float = 0.0

@export var health: float = 0.0
@export var health_mod: float = 1.0

func apply_stats(stats: EquipmentStats):
	self.damage += stats.damage
	self.damage_mod *= stats.damage_mod
	
	self.cooldown += stats.cooldown
	self.cooldown_mod *= stats.cooldown_mod
	
	self.warmup += stats.warmup
	self.warmup_mod *= stats.warmup_mod
	
	self.defence += stats.defence
	self.defence_mod *= stats.defence_mod
	
	self.blocked_percent += stats.blocked_percent
	
	self.health += stats.health
	self.health_mod *= stats.health_mod
	
func apply_mods():
	self.damage *= self.damage_mod
	self.cooldown *= self.cooldown_mod
	self.warmup *= self.warmup_mod
	self.defence *= self.defence_mod
	self.health *= self.health_mod
