class_name State extends Node

## Reference to player
static var player: Player
static var state_machine: PlayerStateMachine

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func init() -> void:
	pass

## Enters the state
func Enter() -> void: 
	pass

## Exits the state
func Exit() -> void:
	pass

## _process updates the state
func Process(_delta: float) -> State:
	return null

## _physics_process updates the state
func Physics(_delta: float) -> State:
	return null
	
## input event updates state
func HandleInput(_event: InputEvent) -> State:
	return null
