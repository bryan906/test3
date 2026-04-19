extends Node2D

var money: int = 1000
var income_per_cycle: int = 100
var cycle_timer: float = 0.0
var cycle_length: float = 10.0

var money_label: Label
var main_panel: Panel

func _ready() -> void:
	money_label = find_child("MoneyLabel", true, false)
	main_panel = find_child("MainPanel", true, false)
	
	get_viewport().size_changed.connect(_on_viewport_size_changed)
	
	update_layout()
	update_ui()

func update_layout() -> void:
	var screen = get_viewport().get_visible_rect().size
	
	# Fix background
	var bg = $Background
	bg.position = Vector2(screen.x / 2, screen.y / 2)
	var tex_size = bg.texture.get_size()
	bg.scale = Vector2(screen.x / tex_size.x, screen.y / tex_size.y)
	
	# Fix camera
	$Camera2D.position = Vector2(screen.x / 2, screen.y / 2)
	
	# Money label top left
	money_label.position = Vector2(10, 10)
	
	# Panel at bottom center
	main_panel.size = Vector2(500, 120)
	main_panel.position = Vector2((screen.x / 2) - 250, screen.y - 130)

func _on_viewport_size_changed() -> void:
	update_layout()

func _process(delta: float) -> void:
	cycle_timer += delta
	if cycle_timer >= cycle_length:
		cycle_timer = 0.0
		earn_income()

func earn_income() -> void:
	money += income_per_cycle
	update_ui()

func spend_money(amount: int) -> bool:
	if money >= amount:
		money -= amount
		update_ui()
		return true
	print("Not enough money!")
	return false

func update_ui() -> void:
	if money_label:
		money_label.text = "$" + str(money)
