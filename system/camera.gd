extends Camera2D

func _ready() -> void:
	Global.debugZoomIn.connect(zoomIn)
	Global.debugZoomOut.connect(zoomOut)

func zoomIn():
	zoom += Vector2(0.1, 0.1)
	
func zoomOut():
	zoom -= Vector2(0.1, 0.1)
