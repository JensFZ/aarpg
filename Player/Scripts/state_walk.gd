class_name State_Walk extends State

@export var move_speed : float = 100.0
@onready var idle: State = $"../Idle"

## Enters the state
func Enter() -> void: 
	player.UpdateAnimation("walk")
	pass

## Exits the state
func Exit() -> void:
	pass

## _process updates the state
func Process(_delta: float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
		
	player.velocity = player.direction * move_speed
	
	if player.SetDirection():
		player.UpdateAnimation("walk")
	return null

## _physics_process updates the state
func Physics(_delta: float) -> State:
	return null
	
## input event updates state
func HandleInput(_event: InputEvent) -> State:
	return null
