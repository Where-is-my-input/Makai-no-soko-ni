extends Node

enum Core {
	CORELESS,
	BAND, #This is how it feels to play on a Band (15f parry)
	FRAGILE, #Hardcore mode, This crest feeds on your very existence
	EVER, #Evercrest, no xp and no fragments
	NOHIT, #Hitless mode
	KUDOS, #Kudos mode, more damage the higher the combo without getting hit, 0 damage at 0 hits combo
}

enum Fragment {
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

enum Character {
	CECILIA, 
	GEOVANNA, 
}

@export var savePath = "user://save.save"

var character:Character = Character.GEOVANNA
var core:Core = Core.CORELESS
@export var fragments:Array[Fragment]

#Upgrades
var dashes:int = 0
var jumps:int = 1

var currentSlot:int = 0

func reset():
	character = Character.GEOVANNA
	core = Core.CORELESS
	fragments.clear()

func setCharacterSelected(c:Character = Character.GEOVANNA):
	character = c

func setCoreSelected(c:Core = Core.CORELESS):
	core = c

func saveGame():
	var file = FileAccess.open(savePath, FileAccess.WRITE)
	file.store_var(core)
	file.store_var(InGameTimer.time)

func loadGame():
	if FileAccess.file_exists(savePath):
		var file = FileAccess.open(savePath, FileAccess.READ)
		core = file.get_var(core)
		InGameTimer.time = file.get_var(InGameTimer.time)
		
