extends Node
class_name level_system

@export var level = 0
@export var xp = 0

signal levelUp

const CONST_XP = 25

func gainXP(value = 0):
	xp += value
	if xp >= xpNeeded():
		LevelUp()
		gainXP()

func LevelUp(value = 1):
	level += value
	levelUp.emit(level)

func xpNeeded():
	return level^5 + CONST_XP
