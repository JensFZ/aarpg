extends Node2D

func _ready() -> void:
	visible = false
	
	# Code für den Spielstart
	if PlayerManager.player_spawned == false:
		PlayerManager.set_player_position( global_position )
		PlayerManager.player_spawned = true
