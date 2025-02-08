class_name Player extends CharacterBody2D

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]

var cardinal_direction : Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
var invulnerable: bool = false 

@export var hp : int = 6 # export hinzugefügt
@export var max_hp: int = 6 # export hinzugefügt

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var hit_box: HitBox = $HitBox

signal direction_changed( new_Direction : Vector2 )
signal player_damaged( hurt_box: HurtBox )


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Statemachine vorbereiten
	PlayerManager.player = self
	state_machine.Initialize(self)	
	hit_box.damaged.connect( _take_damage )
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

func _take_damage(Hurt_box: HurtBox) -> void:
	
	pass
	
func update_hp( delta: int ) -> void:
	
	pass

func make_invulnerable( ) -> void:
	
	pass
