extends Node
class_name level_system

@export var level = 0
@export var xp = 0
@export var xpExponential = 5

signal levelUp
signal xpGained

const CONST_XP = 25

func gainXP(value = 0):
	xp += value
	if xp >= xpNeeded():
		LevelUp()
		xp -= xpNeeded()
		gainXP()
	xpGained.emit(xp)

func LevelUp(value = 1):
	level += value
	levelUp.emit(level)

func xpNeeded():
	return level^xpExponential + CONST_XP
