@tool
class_name DialogPortrait extends Sprite2D

var blink : bool = false : set = _set_blink
var open_mouth : bool = false : set = _set_open_mouth
var mouth_open_frames : int = 0


@onready var audio: AudioStreamPlayer = $"../AudioStreamPlayer"


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	DialogSystem.letter_added.connect( check_mouth_open )
	blinker()


func _set_blink( _v : bool ) -> void:
	if blink != _v:
		blink = _v
		update_portrait()

	pass

func _set_open_mouth( _v : bool ) -> void:
	if open_mouth != _v:
		open_mouth = _v
		update_portrait()

	pass
	
func update_portrait() -> void:
	if open_mouth == true:
		frame = 2
	else:
		frame = 0
	
	if blink == true:
		frame += 1
	
	

func blinker() -> void:
	if blink == false:
		await get_tree().create_timer( randf_range(0.1, 3)).timeout
	else:
		await get_tree().create_timer( 0.15 ).timeout
	
	blink = not blink
	blinker()

func check_mouth_open( _s : String ) -> void:
	if 'aeiouy1234567890'.contains( _s ):
		open_mouth = true
		mouth_open_frames += 3
		audio.pitch_scale = randf_range( 0.96, 1.04 )
		audio.play()
		
	elif '.,!?'.contains( _s ):
		mouth_open_frames = 0

	if mouth_open_frames > 0:
		mouth_open_frames -= 1
		
	
	if mouth_open_frames == 0:
		open_mouth = false
	
	pass
