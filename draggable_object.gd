class_name DraggableObject
extends TextureRect

var drag_offset: Vector2

func _get_drag_data(at_position: Vector2) -> Variant:
	self_modulate.a = 0 # Hide node, but not its children.
	
	var drag_preview = Control.new()
	
	var child: TextureRect = TextureRect.new()
	child.texture = texture
	drag_preview.add_child(child)
	
	# Compensate mouse position.
	child.position = Vector2(-at_position.x, -at_position.y)
	drag_offset = child.position
	
	set_drag_preview(drag_preview)
	return self

func _can_drop_data(_at_position: Vector2, _data: Variant) -> bool:
	# Allow dropping an object over another one (or over itself).
	return true

func _drop_data(at_position: Vector2, data: Variant) -> void:
	data.position = position + at_position + data.drag_offset

func make_visible() -> void:
	self_modulate.a = 1

# When a drag ends, make the object visible again.
func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_END:
		make_visible()
