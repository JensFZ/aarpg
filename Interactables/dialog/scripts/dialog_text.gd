@tool
@icon("res://GUI/dialog_system/icons/text_bubble.svg")
class_name DialogText extends DialogItem

@export_multiline var text : String = "Placeholder" : set = _set_text


func _set_editor_display() -> void:
	example_dialog.set_dialog_text( self )
	example_dialog.content.visible_characters = -1
	pass

func _set_text( _v : String ) -> void:
	text = _v
	if Engine.is_editor_hint():
		if example_dialog:
			_set_editor_display()
	
