extends Control

# let's define text and speed
var current_node = "start"
var display_text = ""
var current_char_index = 0
var text_speed = 0.05
var story_nodes
var story_text
var i = 0
var label = ""

@onready var story_label = $"../Control/CenterContainer/VBoxContainer/StoryText"
@onready var text_timer = $"../Control/TextTimer"
@onready var choice1_button = $"../Control/CenterContainer/VBoxContainer/Choice1"
@onready var choice2_button = $"../Control/CenterContainer/VBoxContainer/Choice2"
@onready var choice_buttons = [$"../Control/CenterContainer/VBoxContainer/Choice1", $"../Control/CenterContainer/VBoxContainer/Choice2"]
@onready var background = $"../ColorRect"

# Called when the node enters the scene tree for the first time.
func _ready():
	var story_data = load("res://Story_Data.gd").new()
	story_nodes = story_data.story_nodes
	
	story_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	story_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER

	story_label.add_theme_color_override("font_color", Color(1,1,1))
	
	text_timer.wait_time = text_speed
	text_timer.timeout.connect(self._on_TextTimer_timeout)
	_load_story_node(current_node)
	choice1_button.custom_minimum_size = Vector2(200, 40)
	choice2_button.custom_minimum_size = Vector2(200, 40)
	_position_choice_buttons()
	
func start_new_game():
	current_node = "start"	
	_load_story_node(current_node)
	
func load_game_state(game_state):
	current_node = game_state["current_node"]
	display_text = game_state["display_text"]
	current_char_index = game_state["current_char_index"]
	_load_story_node(current_node)

func _position_choice_buttons():
	var base_y = story_label.position.y + story_label.size.y + 20
	choice1_button.position = Vector2((size.x - choice1_button.custom_minimum_size.x) / 2, base_y)
	choice2_button.position = Vector2((size.x - choice2_button.custom_minimum_size.x) / 2, base_y + choice1_button.custom_minimum_size.y + 20)
	
func _load_story_node(node_key):
	current_node = node_key
	display_text = ""
	current_char_index = 0
	story_label.text = display_text
	text_timer.start()
	
	var node = story_nodes[node_key]
	story_text = node["text"]
	var choices = node["choices"]
	
	for i in range(choice_buttons.size()):
		if i < choices.size():
			choice_buttons[i].text = choices[i]["label"]
			choice_buttons[i].visible = false
		else:
			choice_buttons[i].visible = false
	
func _on_TextTimer_timeout():
	if current_char_index < story_text.length():
		display_text += story_text[current_char_index]
		story_label.text = display_text
		current_char_index += 1
	else:
		text_timer.stop()
		_show_choices()
		
func _show_choices():
	var choices = story_nodes[current_node]["choices"]
	for i in range(choices.size()):
		if i < choices.size():
			choice_buttons[i].visible = true
			choice_buttons[i].text = choices[i]["label"]
			choice_buttons[i].pressed.disconnect(self._on_choice_pressed)
			choice_buttons[i].pressed.connect(_on_choice_pressed.bind(choices[i]["target"]))
		else:
			choice_buttons[i].visible = false
	
func _on_choice_pressed(choice_key):
	for button in choice_buttons:
		button.pressed.disconnect(self._on_choice_pressed)
		button.visible = false
	_load_story_node(choice_key)
	
func save_game_state():
	var game_state = {
		"current node": current_node,
		"display_text": display_text,
		"current_char_index": current_char_index
	}
	var main_scene = get_tree().root.get_node("Main")
	main_scene.save_game_state(game_state)
