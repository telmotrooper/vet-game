extends Button

@export var value := ""

signal question_answered

func _pressed() -> void:
	question_answered.emit(value)

func freeze() -> void:
	disabled = true
	set_mouse_filter(MOUSE_FILTER_IGNORE)
