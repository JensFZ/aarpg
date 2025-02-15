class_name State_Idle extends State

@onready var walk: State = $"../Walk"
@onready var attack: State = $"../Attack"


## Enters the state
func Enter() -> void: 
	player.update_animation("idle")
	pass

## Exits the state
func Exit() -> void:
	pass

## _process updates the state
func Process(_delta: float) -> State:
	if player.direction != Vector2.ZERO: #Da ist Bewegung im Spiel
		return walk
	player.velocity = Vector2.ZERO
	return null

## _physics_process updates the state
func Physics(_delta: float) -> State:
	return null
	
## input event updates state
func HandleInput(_event: InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	if _event.is_action_pressed("interact"):
		PlayerManager.interact_pressed.emit()
	return null
