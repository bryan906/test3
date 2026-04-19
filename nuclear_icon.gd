extends TextureRect

const NuclearScene = preload("res://Nuclear.tscn")
var active_nuclear = null

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if active_nuclear == null:
				spawn_nuclear()

func spawn_nuclear() -> void:
	var nuclear = NuclearScene.instantiate()
	get_node("/root/Game").add_child(nuclear)
	active_nuclear = nuclear
	nuclear.start_drag()
	nuclear.placed.connect(_on_nuclear_placed)

func _on_nuclear_placed() -> void:
	active_nuclear = null
