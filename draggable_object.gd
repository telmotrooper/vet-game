class_name DraggableObject
extends TextureRect

func _get_drag_data(_at_position: Vector2) -> Variant:
	self_modulate.a = 0 # Hide node, but not its children.
	
	var drag_preview = Control.new()
	
	var child: TextureRect = TextureRect.new()
	child.texture = texture
	drag_preview.add_child(child)
	
	# Position preview at the center of the mouse.
	var texture_size = child.texture.get_size()
	child.position = Vector2(-texture_size.x / 2, -texture_size.y / 2)
	
	set_drag_preview(drag_preview)
	return self

# This is called when the object is dropped in a different position.
func _on_item_rect_changed() -> void:
	self_modulate.a = 1 # Display node again.
