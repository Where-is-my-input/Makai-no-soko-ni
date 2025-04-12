extends Node
class_name level_system

@export var level = 0
@export var xp = 0
@export var xpExponential = 3

signal levelUp
signal xpGained

const CONST_XP = 250
var xpRequiredToLevelUp = 0

func _ready() -> void:
	xpRequiredToLevelUp = xpNeeded()

func gainXP(value = 0):
	xp += value
	if xp >= xpRequiredToLevelUp:
		LevelUp()
		xp -= xpRequiredToLevelUp
		gainXP()
	xpGained.emit(xp)

func LevelUp(value = 1):
	level += value
	levelUp.emit(level)
	xpRequiredToLevelUp = xpNeeded()
	print(xpRequiredToLevelUp)

func xpNeeded():
	return (level**xpExponential) - (level^level + level * level) + CONST_XP

func getStamina() -> int:
	return sqrt(level) + 100
	
func getDefense() -> int:
	return sqrt(level) + 1
	
func getAttack() -> int:
	return sqrt(level) + 10
	
func getHP() -> int:
	return sqrt(level) + 10
