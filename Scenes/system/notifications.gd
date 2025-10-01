extends Node

signal enemyHit


func enemyGotHit(enemyName:String = "Enemy", maxHp:int = 10, currentHp:int = 10):
	enemyHit.emit(enemyName, maxHp, currentHp)
