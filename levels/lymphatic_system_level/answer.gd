extends Button

@export var value := ""

signal question_answered

func _pressed() -> void:
	question_answered.emit(self, value)

func freeze() -> void:
	set_mouse_filter(MOUSE_FILTER_IGNORE)
