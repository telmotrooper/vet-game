extends TextureRect
class_name Slot

@export var expected_value: String

signal slot_filled

func _ready() -> void:
	pass
	#self_modulate.a = 0

func _can_drop_data(_at_position: Vector2, _data: Variant) -> bool:
	return true

func _drop_data(at_position: Vector2, data: Variant) -> void:
	if data.value == expected_value:
		# Make the size of the object match that of the slot (to centralize text).
		data.size.x = data.size.x if (data.size.x > size.x) else size.x
		# Move the object to the exact position of the slot.
		data.position = position
		slot_filled.emit()
		data.freeze()
	else:
		# Compensate the offset so that the object is placed in the position of the drag preview.
		data.position = position + at_position + data.drag_offset
