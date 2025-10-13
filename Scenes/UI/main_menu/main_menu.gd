extends Control
@onready var btnPlay: Button = $vBox/play

@export var play:PackedScene
@export var options:PackedScene
@export var credits:PackedScene
@export var newGame:PackedScene

func _ready() -> void:
	btnPlay.grab_focus()
	Inventory.reset()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(play)

func _on_options_pressed() -> void:
	get_tree().change_scene_to_packed(options)
	
func _on_credits_pressed() -> void:
	get_tree().change_scene_to_packed(credits)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(newGame)

func _on_load_pressed() -> void:
	Inventory.loadGame()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
