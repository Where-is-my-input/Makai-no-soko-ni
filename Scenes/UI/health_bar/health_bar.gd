extends ProgressBar

func _init(maxV = 50, v = 50) -> void:
	max_value = maxV
	value = v

func updateHealth(newValue):
	value = newValue

func setMaxHealth(v):
	max_value = v
