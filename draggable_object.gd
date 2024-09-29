class_name DraggableObject
extends TextureRect

@export var value: String

var drag_offset: Vector2

var frozen := false

func freeze() -> void:
	frozen = true

func _get_drag_data(at_position: Vector2) -> Variant:
	if frozen:
		return null
	
	self_modulate.a = 0 # Hide node, but not its children.
	set_mouse_filter(MOUSE_FILTER_IGNORE) # Pass through mouse events.
	
	var drag_preview = Control.new()
	
	var child: TextureRect = TextureRect.new()
	child.texture = texture
	drag_preview.add_child(child)
	
	# Compensate mouse position.
	child.position = Vector2(-at_position.x, -at_position.y)
	drag_offset = child.position
	
	set_drag_preview(drag_preview)
	return self

func make_visible() -> void:
	self_modulate.a = 1
	set_mouse_filter(MOUSE_FILTER_PASS) # Capture mouse events.

# When a drag ends, make the object visible again.
func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_END:
		make_visible()
