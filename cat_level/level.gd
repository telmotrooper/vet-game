extends Node2D

var slot_counter: int
var score := 0

func _ready() -> void:
	for child in %Slots.get_children():
		if child is Slot:
			slot_counter += 1
	
	%Score.text = "[b]Acertos:[/b] %d/%d" % [score, slot_counter]

func _on_slot_filled() -> void:
	score += 1
	%Score.text = "[b]Acertos:[/b] %d/%d" % [score, slot_counter]
