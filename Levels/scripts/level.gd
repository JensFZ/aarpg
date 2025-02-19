class_name Level extends Node2D

@onready var enemy_counter: EnemyCounter = $EnemyCounter


func _ready() -> void:
	self.y_sort_enabled = true
	PlayerManager.set_as_parent( self )
	LevelManager.level_load_started.connect ( _free_level )

func _free_level() -> void:
	PlayerManager.unparent_player( self ) #erst player vom Level lösen
	queue_free() # Level wegwerfen
