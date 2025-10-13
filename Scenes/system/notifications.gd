extends Node

signal enemyHit


func enemyGotHit(enemyName:String = "Enemy", maxHp:int = 10, currentHp:int = 10, damageDealt:int = 0, hitPos:Vector2 = Vector2(0,0)):
	enemyHit.emit(enemyName, maxHp, currentHp, damageDealt, hitPos)
