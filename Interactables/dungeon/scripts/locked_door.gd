class_name LockedDoor extends Node2D

var is_opend : bool = false

@export var key_item : ItemData

@export var locked_audio : AudioStream
@export var open_audio : AudioStream

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var is_open_data: PersistentDataHandler = $PersistenDataHandler
@onready var interact_area: Area2D = $InteractArea2D


func _ready() -> void:
	interact_area.area_entered.connect( _on_area_enter )
	interact_area.area_exited.connect( _on_area_exit )
	
func open_door() -> void:
	if key_item == null:
		return
	
	var door_unlocked = PlayerManager.INVERNTORY_DATA.use_item( key_item )
	
	if door_unlocked:
		animation_player.play( "open_door" )
		audio.stream = open_audio
		is_open_data.set_value()
	else:
		audio.stream = locked_audio
		
	audio.play()

func close_door() -> void:
	animation_player.play( "close_door" )


func _on_area_enter( _a : Area2D ) -> void:
	PlayerManager.interact_pressed.connect( open_door )

func _on_area_exit (_a : Area2D ) -> void:
	PlayerManager.interact_pressed.disconnect( open_door )
	pass
