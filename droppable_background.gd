extends Control

func _can_drop_data(_at_position: Vector2, _data: Variant) -> bool:
	# Allow dropping the object anywhere in the background.
	return true

func _drop_data(at_position: Vector2, data: Variant) -> void:
	# Compensate the offset so that the object is placed in the position of the drag preview.
	data.position = position + at_position + data.drag_offset
