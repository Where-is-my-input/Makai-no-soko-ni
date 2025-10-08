extends EnemyClass

func _physics_process(delta: float) -> void:
	super(delta)
	if is_on_wall(): flip()

func flip(_body: Node2D = null):
	super()
