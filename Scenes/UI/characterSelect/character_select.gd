extends Control


func _on_btn_cecilia_pressed() -> void:
	Inventory.setCharacterSelected(Inventory.Character.CECILIA)


func _on_btn_geovanna_pressed() -> void:
	Inventory.setCharacterSelected(Inventory.Character.GEOVANNA)


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
