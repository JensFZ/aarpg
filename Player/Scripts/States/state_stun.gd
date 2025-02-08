class_name State_Stun extends State

@export var knockback_speed: float = 200.0
@export var decelerate_speed: float = 10.0
@export var invulnerable_duration: float = 1.0

var hurt_box: HurtBox
var direction: Vector2

var next_state: State = null

@onready var idle: State = $"../Idle"

func init() -> void:
	player.player_damaged.connect ( _player_damaged )

## Enters the state
func Enter() -> void: 	
	player.update_animation( "stun" )
	player.animation_player.animation_finished.connect( _animation_finished )
	
	direction = player.global_position.direction_to( hurt_box.global_position )
	player.velocity = direction * -knockback_speed
	player.set_direction()

	player.make_invulnerable( invulnerable_duration )
	player.effect_animation_player.play("damaged")
	
	pass

## Exits the state
func Exit() -> void:
	next_state = null
	player.animation_player.animation_finished.disconnect( _animation_finished )
	pass

## _process updates the state
func Process(_delta: float) -> State:
	return next_state

## _physics_process updates the state
func Physics(_delta: float) -> State:
	return null
	
## input event updates state
func HandleInput(_event: InputEvent) -> State:
	return null

func _player_damaged( _hurt_box: HurtBox ) -> void:
	hurt_box = _hurt_box
	state_machine.change_state( self )
	pass

func _animation_finished( _a:String ) -> void:
	next_state = idle
