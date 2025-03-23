extends Node

var scene:String
signal progressChanged
var progress:Array

# Called when the node enters the scene tree for the first time.
func loadScene(nextScene:String) -> void:
	scene = nextScene
	ResourceLoader.load_threaded_request(scene, "", true)
	set_process(true)

func _process(_delta: float) -> void:
	#if tmr_wait.is_stopped():
	match ResourceLoader.load_threaded_get_status(scene, progress):
		0,1:
			set_process(false)
		2:
			progressChanged.emit(progress[0])
		3:
			progressChanged.emit(progress[0])
			var loadedResource = ResourceLoader.load_threaded_get(scene)
			get_tree().change_scene_to_packed(loadedResource)
			set_process(false)
	#sprite_2d.rotate(365)
