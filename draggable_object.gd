class_name DraggableObject
extends TextureRect

func _get_drag_data(_at_position: Vector2) -> Variant:
	self_modulate.a = 0 # Hide node, but not its children.
	
	var drag_preview = Control.new()
	
	var child: TextureRect = TextureRect.new()
	child.texture = texture

	# TODO
	drag_preview.add_child(child)
	
	set_drag_preview(drag_preview)
	
	return self

# This is called when the object is dropped in a different position.
func _on_item_rect_changed() -> void:
	self_modulate.a = 1 # Display node again.