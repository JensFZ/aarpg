class_name State_Attack extends State

var attacking: bool = false
@export var attack_sound: AudioStream
@export_range(1,20,0.5) var decelerate_speed: float = 5

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_animation_player: AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"

@onready var walk: State = $"../Walk"
@onready var idle: State = $"../Idle"

@onready var hurt_box: HurtBox = $"../../Interactions/HurtBox"


## Enters the state
func Enter() -> void: 
	player.UpdateAnimation("attack")
	attack_animation_player.play("attack_" + player.AnimDirection())
	
	audio.stream = attack_sound
	audio.pitch_scale = randf_range( 0.9, 1.1 )
	audio.play()
	
	animation_player.animation_finished.connect(EndAttack)
	attacking = true
	
	await get_tree().create_timer(0.075).timeout
	hurt_box.monitoring = true
	
	pass

## Exits the state
func Exit() -> void:
	animation_player.animation_finished.disconnect(EndAttack)
	attacking = false
	hurt_box.monitoring = false
	pass

## _process updates the state
func Process(_delta: float) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	
	if attacking == false :
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
			
	return null

## _physics_process updates the state
func Physics(_delta: float) -> State:
	return null
	
## input event updates state
func HandleInput(_event: InputEvent) -> State:
	return null


func EndAttack(_newAnimName: String) -> void:
	attacking = false
