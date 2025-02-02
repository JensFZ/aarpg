class_name HurtBox extends Area2D

@export var damage : int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect( AreaEntered )
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func AreaEntered( _area: Area2D ) -> void:
	if _area is HitBox:
		_area.TakeDamage( damage )
	pass
