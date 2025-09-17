extends Node
@export var body:CharacterBody2D
@export var ap:AnimationPlayer
@export var moves:Array[int]

var previousAttack:int = 0
var currentAttack:int = 0
var attackHit:bool = false
var moveCount:int = 0
var maxSize:int = 100

func _ready() -> void:
	for c in get_children():
		moves.push_back(c.get_index())
	moveCount = moves.size()# - 1
	previousAttack = getRandomMove()
	currentAttack = getRandomMove()

func nextAttack() -> Node:
	if !attackHit: attackFailed()
	attackHit = false
	previousAttack = currentAttack
	currentAttack = getRandomMove()
	if currentAttack == previousAttack: currentAttack = getRandomMove()
	return get_child(currentAttack)

func attackSuccessful():
	attackHit = true
	if moves.size() >= maxSize: return
	moves.push_back(currentAttack)

func attackFailed():
	moves.remove_at(moves.find(currentAttack, moveCount))

func getRandomMove() -> int:
	#return randi_range(0, moveCount)
	return moves.pick_random() if !moves.is_empty() else 0
