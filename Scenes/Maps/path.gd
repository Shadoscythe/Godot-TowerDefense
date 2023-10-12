extends Path2D

signal wave_cleared

func _ready():
	print(get_child_count())
func _on_child_exiting_tree(node):
	print("kill")
	await get_tree().process_frame #waits for all queue_free tanks to be freed
	print(get_child_count())
	if get_child_count() == 0:
		wave_cleared.emit()
		print("wavedone")
		
