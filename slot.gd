extends TextureRect

func _can_drop_data(_at_position: Vector2, _data: Variant) -> bool:
	print("_can_drop_data")
	return true

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	data.position = position
	print(data)
