extends Node2D
@onready var button: Button = $Control/BoxContainer/Button

func _ready() -> void:
	button.grab_focus()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
