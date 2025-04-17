extends Node2D

func _ready() -> void:
	Global.hitstop.connect(setHitstop)
	Global.stage = self
	process_mode = Node.PROCESS_MODE_PAUSABLE

func setHitstop(amountOfHitstop = 10):
	#process_mode = Node.PROCESS_MODE_DISABLED
	pass
