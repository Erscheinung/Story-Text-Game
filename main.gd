extends Node2D

@onready var start_ui = $StartUI
@onready var game_control = $Control
# Called when the node enters the scene tree for the first time.
func _ready():
	start_ui.visible = true
	game_control.visible = false
	
	var new_game_button = start_ui.get_node("VBoxContainer/NewGameButton")
	var load_game_button = start_ui.get_node("VBoxContainer/LoadGameButton")
	new_game_button.text = "New Game"
	load_game_button.text = "Load Game"
	new_game_button.pressed.connect(self._on_NewGameButton_pressed)
	load_game_button.pressed.connect(self._on_LoadGameButton_pressed)
	
func _on_NewGameButton_pressed():
	start_ui.visible = false
	game_control.visible = true
	game_control.start_new_game()
	
func _on_LoadGameButton_pressed():
	if load_game_state():
		start_ui.visible = false
		game_control.visible = true
	else:
		print("No save data found")

func save_game_state(state):
	var save_path = "user://savegame.dat"
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(state)
	file.close()
	
func load_game_state():
	var save_path = "user://savegame.dat"
	var file = FileAccess.open(save_path, FileAccess.READ)
	if file:
		var game_state = file.get_var()
		file.close()
		game_control.load_game_state(game_state)
		return true
	return false
