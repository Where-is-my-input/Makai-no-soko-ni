extends CharacterBody2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var open:bool = true

func _ready() -> void:
	setOpen(open)

func setOpen(v = true):
	open = v
	#collision_shape_2d.disabled = open
	collision_shape_2d.set_deferred("disabled", open)
