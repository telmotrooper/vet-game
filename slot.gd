extends TextureRect
class_name Slot

func _ready() -> void:
	pass
	#self_modulate.a = 0

func _can_drop_data(_at_position: Vector2, _data: Variant) -> bool:
	return true

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	# Move the object to the exact position of the slot.
	data.position = position
