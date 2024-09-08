class_name DraggableObject
extends TextureRect

func _get_drag_data(_at_position: Vector2) -> Variant:
	var drag_preview = Control.new()
	
	var child: TextureRect = TextureRect.new()
	child.texture = texture

	# TODO
	drag_preview.add_child(child)
	
	set_drag_preview(drag_preview)
	
	return self
