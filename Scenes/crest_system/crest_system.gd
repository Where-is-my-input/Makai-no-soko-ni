extends Node

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
	ATTACK, #Attack boost
	HP, #HP boost
	CRITICAL, #Attack*4 when HP below 1/4
	DEFENCE, #Defence boost
	SPEED, #Speed boost
	HEALING, #Slowly heals HP when idle, X3 style
	BLEED, #Half of the damage taken turns into red health that heals when hitting an enemy
	IMMOVABLE, #No knockback but take double damage
}

@export var core:Node
@export var fragments:Array[Node]

func _physics_process(delta: float) -> void:
	pass
