extends Control

var slot_counter: int
var score := 0
var mistakes := 0

const base_text := "[center][b]( Acertos:[/b] %d/%d )[/center]"

func _ready() -> void:
	%VictoryPanel.visible = false
	%VictoryPanel.scale = Vector2.ZERO
	for child in %Slots.get_children():
		if child is Slot:
			slot_counter += 1
	update_text()

func _on_slot_filled() -> void:
	score += 1
	update_text()
	if score == slot_counter:
		show_victory_panel()

func update_text() -> void:
	%Score.text = base_text % [score, slot_counter]

func show_victory_panel() -> void:
	if mistakes == 0:
		%VictoryPanel.set_stars(3)
	elif mistakes <= 3:
		%VictoryPanel.set_stars(2)
	else:
		%VictoryPanel.set_stars(1)
	
	%VictoryPanel.show_panel()

func _on_mistake_made():
	mistakes += 1
