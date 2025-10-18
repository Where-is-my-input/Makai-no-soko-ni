extends CharacterBody2D
class_name projectile

@export var direction:Vector2 = Vector2(20, 0)
@export var timeToDespawnOffscreen:float = 5
@onready var tmr_dspawn: Timer = $VisibleOnScreenNotifier2D/tmrDspawn

func _physics_process(delta: float) -> void:
	velocity = direction
	move_and_slide()

func _on_a_2d_hitbox_body_entered(body: Node2D) -> void:
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	tmr_dspawn.start(timeToDespawnOffscreen)

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	tmr_dspawn.stop()

func _on_tmr_dspawn_timeout() -> void:
	queue_free()

func _on_a_2d_hitbox_blocked() -> void:
	queue_free()
