class_name DraggableObject
extends TextureRect

func _get_drag_data(_at_position: Vector2) -> Variant:
	var drag_preview = TextureRect.new()
	drag_preview.texture = texture
	set_drag_preview(drag_preview)
	return self

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return true

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	pass
