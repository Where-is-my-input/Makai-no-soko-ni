extends TileMapLayer

func set_camera_limits(playerCamera):
	var map_limits = get_used_rect()
	var map_cellsize = tile_set.tile_size
	playerCamera.limit_left = map_limits.position.x * map_cellsize.x + global_position.x
	playerCamera.limit_right = map_limits.end.x * map_cellsize.x + global_position.x
	playerCamera.limit_top = map_limits.position.y * map_cellsize.y + global_position.y
	playerCamera.limit_bottom = map_limits.end.y * map_cellsize.y + global_position.y
