extends TextureRect

const CoalScene = preload("res://Coal.tscn")
var active_coal = null

func _gui_input(event: InputEvent) -> void:
	print("clicked!")  # add this
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("left click registered!")  # add this
			if active_coal == null:
				spawn_coal()

func spawn_coal() -> void:
	var coal = CoalScene.instantiate()
	get_node("/root/Game").add_child(coal)
	active_coal = coal
	coal.start_drag()
	coal.placed.connect(_on_coal_placed)

func _on_coal_placed() -> void:
	active_coal = null
