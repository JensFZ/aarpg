extends CanvasLayer


var hearts: Array[ HeartGUI ] = []


func _ready() -> void:
	for child in $Control/HFlowContainer.get_children():
		if child is HeartGUI:
			hearts.append(child)
			child.visible = false
	pass 

func update_hp(_hp: int, _max_hp: int ) -> void:
	update_max_hp( _max_hp )
	for i in round(_max_hp * 0.5): # 0...round(_max_hp * 0.5) - Abweichung zum Tutorial, da dort ein Bug ist
		update_heart( i , _hp )
	pass

func update_heart( _index: int, _hp: int ) -> void:
	var _value : int = clampi(_hp - _index * 2, 0, 2) # Berechnet den wert pro herz
	hearts[ _index ].value = _value
	pass

func update_max_hp( _max_hp: int ) -> void:
	var _heart_count : int = round( _max_hp * 0.5 ) # bei 6 max -> 3 Herzen
	
	for i in hearts.size():
		if i < _heart_count:
			hearts[i].visible = true 
		else:
			hearts[i].visible = false 
	
	pass
