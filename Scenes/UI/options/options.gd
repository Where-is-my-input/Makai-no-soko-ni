extends Control

#res 1280x720, 1600x900, 1920x1080

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DisplayServer.window_set_size(Vector2i(1920,1080))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_btn_button_map_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/options/button_mapping.tscn")
