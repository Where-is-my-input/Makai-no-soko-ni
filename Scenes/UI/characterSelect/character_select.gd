extends Control
#TODO Liberar crest select new game+

func _on_btn_cecilia_pressed() -> void:
	Inventory.setCharacterSelected(Inventory.Character.CECILIA)
	startGame()


func _on_btn_geovanna_pressed() -> void:
	Inventory.setCharacterSelected(Inventory.Character.GEOVANNA)
	startGame()


func _on_btn_band_pressed() -> void:
	Inventory.setCoreSelected(Inventory.Core.BAND)


func _on_btn_fragile_pressed() -> void:
	Inventory.setCoreSelected(Inventory.Core.FRAGILE)


func _on_btn_ever_pressed() -> void:
	Inventory.setCoreSelected(Inventory.Core.EVER)


func _on_btn_hitless_pressed() -> void:
	Inventory.setCoreSelected(Inventory.Core.NOHIT)


func _on_btn_kudos_pressed() -> void:
	Inventory.setCoreSelected(Inventory.Core.KUDOS)

func startGame():
	get_tree().change_scene_to_file("res://Scenes/stages/world.tscn")
