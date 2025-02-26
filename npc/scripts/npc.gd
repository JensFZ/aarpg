@tool
@icon("res://npc/icons/npc.svg")
class_name NPC extends CharacterBody2D

signal do_behavior_enabled

var state : String = "idle"
var direction : Vector2 = Vector2.DOWN
var direction_name : String = "down"

@export var npc_resource : NPCResource : set = _set_npc_resource

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	#setup NPC
	setup_npc()
	
	if Engine.is_editor_hint():
		return
	pass


func setup_npc() -> void:
	if npc_resource != null:
		if sprite:
			sprite.texture = npc_resource.sprite
	pass

func _set_npc_resource( _npc : NPCResource ) -> void:
	npc_resource = _npc
	setup_npc()
	pass
