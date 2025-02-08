class_name Player extends CharacterBody2D

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]

var cardinal_direction : Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine

signal direction_changed( new_Direction : Vector2 )


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Statemachine vorbereiten
	PlayerManager.player = self
	state_machine.Initialize(self)	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()
	pass

func _physics_process(_delta: float) -> void:
	move_and_slide()	
	

func SetDirection() -> bool: 
	
	if direction == Vector2.ZERO:
		return false

	# direction + cardinal_direction * 0.1 -> die erste Taste die gedrückt wird, gewint die richtung bei diagonal
	# Angle * Tau -> 0..1 für 0° bis 360°
	# dann * DIR_4.Size -> Werte von 0 bis 3
	# Round -> z.B. ab 3,5 -> Wert 4
	var direction_id : int = int( round( ( direction + cardinal_direction * 0.1 ).angle() / TAU * DIR_4.size() ) )
	var new_direction = DIR_4 [ direction_id ]

	if new_direction == cardinal_direction:
		return false
	
	cardinal_direction = new_direction
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	direction_changed.emit( new_direction )
	
	return true

func UpdateAnimation(state : String) -> void:
	animation_player.play(state + "_" + AnimDirection() )
	pass
	
func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
