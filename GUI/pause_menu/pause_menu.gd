extends CanvasLayer

@onready var btn_load: Button = $ColorRect/VBoxContainer/btn_load
@onready var btn_save: Button = $ColorRect/VBoxContainer/btn_save

var is_paused : bool = false 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_pause_menu()
	pass # Replace with function body.


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if is_paused == false:
			show_pause_menu()
		else:
			hide_pause_menu()
		get_viewport().set_input_as_handled()
	

func show_pause_menu() -> void:
	get_tree().paused = true 
	visible = true
	is_paused = true

func hide_pause_menu() -> void:
	is_paused = false
	visible = false
	get_tree().paused = false
