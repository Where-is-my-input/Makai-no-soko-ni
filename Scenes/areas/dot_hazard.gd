extends Area2D

var bodies:Array[CharacterBody2D]
var damageCooldDown:Array[int]

func _ready():
	set_physics_process(false)

func _on_body_entered(body: Node2D) -> void:
	set_physics_process(true)
	bodies.push_back(body)
	damageCooldDown.push_back(0)

func _physics_process(_delta: float) -> void:
	for b in bodies.size():
		if b == null: continue
		if damageCooldDown[b] > 0:
			damageCooldDown[b] -= 1
		else:
			bodies[b].getHit(1, false, Vector2(2000, -500), 0)
			damageCooldDown[b] = 15
	if bodies.is_empty(): set_physics_process(false)

func _on_body_exited(body: Node2D) -> void:
	bodies.erase(body)
