extends Node2D

@onready var animation_player = $Path2D/AnimationPlayer
@onready var animation_tree = $Path2D/AnimationTree
const timeScale = "parameters/TimeScale/scale"

@export var state = true
@export var advance = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if state:
		animation_tree.set(timeScale, 1)
	else:
		#animation_player.stop(true)
		animation_tree.set(timeScale, 0)
	animation_player.seek(advance)

func switch():
	state = !state
	if state:
		animation_tree.set(timeScale, 1)
	else:
		animation_tree.set(timeScale, 0)
