class_name DraggableObject
extends TextureRect

var drag_position: Vector2

func _get_drag_data(at_position: Vector2) -> Variant:
	self_modulate.a = 0 # Hide node, but not its children.
	
	var drag_preview = Control.new()
	
	var child: TextureRect = TextureRect.new()
	child.texture = texture
	drag_preview.add_child(child)
	
	# Compensate mouse position.
	child.position = Vector2(-at_position.x, -at_position.y)
	drag_position = child.position
	
	set_drag_preview(drag_preview)
	return self

func make_visible() -> void:
	self_modulate.a = 1

# If the object position was changed (successful drag), make the object visible again.
func _on_item_rect_changed() -> void:
	make_visible()

# If a drag fails, make the object visible again.
func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_END and not is_drag_successful():
		make_visible()
