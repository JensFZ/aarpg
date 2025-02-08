class_name PlayerStateMachine extends Node

var states: Array[ State ]
var prev_state: State
var current_state: State


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Nicht berechnen, bis initialisierung durch ist
	process_mode = Node.PROCESS_MODE_DISABLED
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_state(current_state.Process( delta ) )
	pass

	
	
func _physics_process(delta: float) -> void:
	change_state(current_state.Physics( delta ) )
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.HandleInput( event ) )
	pass
	
	
func Initialize(_player: Player) -> void:
	states = []
	
	for node in get_children():
		if node is State:
			states.append(node)

	if states.size() == 0:
		return 

	# player in state ist static -> einen setzen, gilt für alle
	states[0].player = _player
	states[0].state_machine = self
	
	for state in states:
		state.init()
	
	# ersten state starten
	change_state(states[0])
	
	# Prozessmode von Disabled auf Inherit setzen -> wird normal berechnet
	process_mode = Node.PROCESS_MODE_INHERIT

func change_state(new_state : State) -> void:
	if new_state == null || new_state == current_state:
		return
	
	## Aktuellen state verlassen, wenn dieser existiert
	if current_state:
		current_state.Exit()
		
	## States sichern und neu zuweisen
	prev_state = current_state
	current_state = new_state
	
	## neuer State starten
	current_state.Enter()
