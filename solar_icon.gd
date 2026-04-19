extends TextureRect

const SolarScene = preload("res://Solar.tscn")
var active_solar = null

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if active_solar == null:
				spawn_solar()

func spawn_solar() -> void:
	var solar = SolarScene.instantiate()
	get_node("/root/Game").add_child(solar)
	active_solar = solar
	solar.start_drag()
	solar.placed.connect(_on_solar_placed)

func _on_solar_placed() -> void:
	active_solar = null
