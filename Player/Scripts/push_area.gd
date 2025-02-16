extends Area2D

func _ready() -> void:
	body_entered.connect( _on_body_enter )
	body_exited.connect( _on_body_exit )
	
func _on_body_enter( b : Node2D ) -> void:
	if b is PuschableStatue:
		b.push_direction = PlayerManager.player.direction
	pass
	
func _on_body_exit( b : Node2D ) -> void:
	if b is PuschableStatue:
		b.push_direction = Vector2.ZERO
	pass
