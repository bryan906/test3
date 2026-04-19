extends Sprite2D

signal placed

var is_dragging: bool = false
var is_placed: bool = false

func _ready() -> void:
	visible = false
	add_to_group("solar")
func start_drag() -> void:
	is_dragging = true
	visible = true

func _process(_delta: float) -> void:
	if is_dragging and not is_placed:
		var tilemap = get_node("/root/Game/TileMapLayer")
		var TILE_SIZE = Vector2(tilemap.tile_set.tile_size)
		var mouse_pos = get_global_mouse_position()
		var local_mouse = mouse_pos - tilemap.global_position
		global_position = (local_mouse / TILE_SIZE).floor() * TILE_SIZE + TILE_SIZE / 2.0 + tilemap.global_position
		if is_valid_placement():
			modulate = Color.WHITE
		else:
			modulate = Color.RED

func is_valid_placement() -> bool:
	var tilemap = get_node("/root/Game/TileMapLayer")
	var tile_pos = tilemap.local_to_map(tilemap.to_local(global_position))
	return tilemap.get_cell_source_id(tile_pos) != -1

func _input(event: InputEvent) -> void:
	if is_dragging and not is_placed:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if is_valid_placement():
					var game = get_node("/root/Game")
					if game.spend_money(150):
						is_placed = true
						is_dragging = false
						modulate = Color.WHITE
						emit_signal("placed")
					else:
						modulate = Color.RED
