extends Button

@export var value := ""

signal question_answered

func _pressed() -> void:
	question_answered.emit(value)
