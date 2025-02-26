@tool
extends NPCBehavior

const DIRECTIONS = [Vector2.UP, Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT ]

@export var wander_range : int = 2 : set = _set_wander_range
@export var wander_speed : float = 30 
@export var wander_duration : float = 1.0
@export var idle_duration : float = 1.0

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var original_position : Vector2

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	super()
	collision_shape_2d.queue_free()
	original_position = npc.global_position

func start() -> void:
	# Idle Phase
	if npc.do_behavior == false:
		return
	
	npc.state = "idle"
	npc.velocity = Vector2.ZERO
	npc.update_animation()
	await get_tree().create_timer( randf()  * idle_duration + idle_duration * 0.5 ).timeout
	
	# Walk Phase
	npc.state = "walk"
	var _direction : Vector2 = DIRECTIONS[ randi_range(0,3) ]
	npc.direction = _direction
	npc.velocity = wander_speed * _direction
	
	npc.update_direction( global_position + _direction )
	npc.update_animation()
	
	await get_tree().create_timer( randf()  * wander_duration + wander_duration * 0.5 ).timeout
	# Repeat
	
	if npc.do_behavior == false:
		return
	start()
	pass

func _set_wander_range( v : int ) -> void:
	wander_range = v
	collision_shape_2d.shape.radius = v * 32.0
