extends Node2D

var slot_counter: int
var score := 0

const base_text := "[b]Acertos:[/b] %d/%d"

func _ready() -> void:
	for child in %Slots.get_children():
		if child is Slot:
			slot_counter += 1
	update_text()

func _on_slot_filled() -> void:
	score += 1
	update_text()

func update_text() -> void:
	%Score.text = base_text % [score, slot_counter]
