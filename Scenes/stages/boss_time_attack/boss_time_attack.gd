extends Node2D
@onready var tile_map: TileMapLayer = $TileMap
@onready var body: CharacterBody2D = $body
@onready var global_camera: Camera2D = $globalCamera

func _ready() -> void:
	body.setCamera(global_camera)
	tile_map.set_camera_limits(global_camera)
