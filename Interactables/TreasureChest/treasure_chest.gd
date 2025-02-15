@tool
class_name TreasureChest extends Node2D

@export var item_data : ItemData : set = _set_item_data
@export var quantity : int = 1 : set = _set_quantity

@onready var sprite: Sprite2D = $Sprite2D
@onready var label: Label = $ItemSprite/Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var interact_area: Area2D = $interact_area


var is_open : bool = false

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	interact_area.area_entered.connect( _on_area_enter )	
	interact_area.area_exited.connect( _on_area_exit )	
	
	pass


func _set_item_data( value : ItemData ) -> void:
	item_data = value

func _set_quantity( value : int ) -> void:
	quantity = value

func _player_interact() -> void:
	if is_open == true:
		return
	
	is_open = true
	animation_player.play("open_chest")
	if item_data and quantity > 0:
		PlayerManager.INVERNTORY_DATA.add_item(item_data, quantity)
	else:
		printerr("No item in chest!")
		push_error("No item in chest! Chest Name: ", name)
		
	pass

func _on_area_enter( a : Area2D) -> void:
	PlayerManager.interact_pressed.connect( _player_interact )
	pass
	
func _on_area_exit( a : Area2D ) -> void:
	PlayerManager.interact_pressed.disconnect( _player_interact )
	pass
