extends CanvasLayer

signal shown
signal hidden

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var btn_load: Button = $Control/HBoxContainer/btn_load
@onready var btn_save: Button = $Control/HBoxContainer/btn_save
@onready var lbl_item_description: Label = $Control/lblItemDescription

var is_paused : bool = false 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_pause_menu()
	
	btn_save.pressed.connect( _on_save_pressed )
	btn_load.pressed.connect( _on_load_pressed ) 
	
	pass # Replace with function body.


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if is_paused == false:
			if DialogSystem.is_active:
				return
			show_pause_menu()
		else:
			hide_pause_menu()
		get_viewport().set_input_as_handled()
	

func show_pause_menu() -> void:
	get_tree().paused = true 
	visible = true
	is_paused = true
	shown.emit()

func hide_pause_menu() -> void:
	is_paused = false
	visible = false
	get_tree().paused = false
	hidden.emit()

func _on_save_pressed() -> void:
	if is_paused == false:
		return
	SaveManager.save_game()
	hide_pause_menu()
	
func _on_load_pressed() -> void:
	if is_paused == false:
		return
	SaveManager.load_game()
	
	await LevelManager.level_load_started #Warten auf Transition
	hide_pause_menu()

func update_item_description( new_text : String ) -> void:
	lbl_item_description.text = new_text
	
func play_audio( audio : AudioStream ) -> void:
	audio_stream_player.stream = audio
	audio_stream_player.play()
