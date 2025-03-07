class_name PuschableStatue extends RigidBody2D

@export var push_speed : float = 30.0
@export var pushable : bool = true

var push_direction : Vector2 = Vector2.ZERO : set = _set_push_direction

@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _physics_process(_delta: float) -> void:
	linear_velocity = push_direction * push_speed
	pass
	
func _set_push_direction( value : Vector2 ) -> void:
	if pushable:
		push_direction = value
	else:
		push_direction = Vector2.ZERO
		
	if push_direction == Vector2.ZERO:
		audio.stop()
	else:
		audio.play()
	pass
