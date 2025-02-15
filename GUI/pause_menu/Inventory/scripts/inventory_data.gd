class_name InventoryData extends Resource

@export var slots : Array[ SlotData ]


func add_item( item: ItemData, count : int = 1 ) -> bool:
	# Wenn schon das item existiert -> anzahl ändern
	for s in slots:
		if s:
			if s.item_data == item:
				s.quantity += count
				return true
	
	# Item noch nicht im Inventar
	for i in slots.size():
		if slots[i] == null:
			var new = SlotData.new()
			new.item_data = item
			new.quantity = count
			
			slots[i] = new 
			return true
	
	# kein freier platz
	print ("full")
	return false
