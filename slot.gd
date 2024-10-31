extends TextureRect
class_name Slot

@export var expected_value: String

var check_mark_texture := "res://assets/check_solid.svg"

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
		data.freeze()
		
		var check_mark := TextureRect.new()
		check_mark.texture = load(check_mark_texture)
		add_child(check_mark) # Already add to the scene tree so we can get the "size".
		
		check_mark.scale = Vector2.ZERO
		check_mark.pivot_offset = check_mark.size / 2
		check_mark.z_index = data.z_index + 2
		
		var score_position = %Score.position + (%Score.size / 2)
		
		var tween = create_tween()
		tween.tween_property(check_mark, "scale", Vector2.ONE, 0.25)
		tween.tween_interval(1.0)
		tween.tween_property(check_mark, "global_position", score_position, 0.5)
		tween.tween_property(check_mark, "scale", Vector2.ZERO, 0.5)
		tween.tween_callback(func():
			slot_filled.emit()
			check_mark.queue_free()
		)
	else:
		# Compensate the offset so that the object is placed in the position of the drag preview.
		data.position = position + at_position + data.drag_offset
