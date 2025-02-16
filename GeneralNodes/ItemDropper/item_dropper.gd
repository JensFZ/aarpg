@tool
class_name ItemDropper extends Node2D

const PICKUP = preload("res://Items/item_pickup/item_pickup.tscn")

@export var item_data : ItemData : set = _set_item_data

var has_droped : bool = false 

@onready var sprite: Sprite2D = $Sprite2D
@onready var has_dropped_data: PersistentDataHandler = $has_dropped_data
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	if Engine.is_editor_hint() == true:
		_update_texture()
		return
	
	sprite.visible = false
	has_dropped_data.data_loaded.connect ( _on_data_loaded )
	_on_data_loaded()
	
func _on_data_loaded() -> void:
	has_droped = has_dropped_data.value

func drop_item() -> void:
	if has_droped == true:
		return
		
	has_droped = true
	
	var drop = PICKUP.instantiate() as ItemPickup
	drop.item_data = item_data
	add_child( drop )
	audio.play()

func _set_item_data( item : ItemData ) -> void:
	item_data = item
	_update_texture()
	pass

func _update_texture() -> void:
	if Engine.is_editor_hint() == true:
		if item_data and sprite:
			sprite.texture = item_data.texture
	pass
