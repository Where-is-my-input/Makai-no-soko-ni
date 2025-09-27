extends Node
const CORE = preload("uid://s4qa87etbg2y")
@onready var body: CharacterBody2D = $"../.."

enum Core {
	BAND, #This is how it feels to play on a Band (15f parry)
	FRAGILE, #Hardcore mode, This crest feeds on your very existence
	EVER, #Evercrest, no xp and no fragments
	NOHIT, #Hitless mode
	KUDOS, #Kudos mode, more damage the higher the combo without getting hit, 0 damage at 0 hits combo
}

enum fragment {
	PARRY, #Enables parries
	MAGNETIC, #??
	LOWHPATTACK, #Attack boost times 4
	FULLHPATTACK, #Attack boost times 2
	HP, #HP boost
	CRITICAL, #Attack*4 when HP below 1/4
	DEFENSE, #Defense boost
	SPEED, #Speed boost
	HEALING, #Slowly heals HP when idle, X3 style
	BLEED, #Half of the damage taken turns into red health that heals when hitting an enemy
	IMMOVABLE, #No knockback but take double damage
}

@export var core:Node
@export var fragments:Array[Node]

func _ready() -> void:
	if core == null:
		var emptyCore = CORE.instantiate()
		core = emptyCore

func gainXP(xp):
	if core.isEvercrest: return 0
	return xp

func returnDamageTaken():
	if core.isNoHit:
		return body.maxHP
	return 0

func isHardcore():
	return core.onDeath && core.isHardcore

func returnDamageDealt(damage, comboCount: int = 0):
	if core.isKudos:
		damage = 0 if comboCount <= 0 else (damage * (comboCount * 0.1)) + damage
	for c in fragments:
		if c.isLowHPAttackBoost:
			damage = damage if body.hp > body.maxHP * 0.25 else damage * 4
		if c.isFullHPAttackBoost:
			damage = damage if body.hp < body.maxHP else damage * 2
	return damage

func canParry():
	for c in fragments:
		if c.enableParry:
			return true
	return false

func speedModifier(speed):
	for f in fragments:
		speed *= f.speedBoostModifier
	return speed
