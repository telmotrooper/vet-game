extends Control

var slot_counter: int
var score := 0

const base_text := "[b]Acertos:[/b] %d/%d"

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
	%VictoryPanel.set_visible(true)
	var tween = create_tween()
	#tween.set_trans(Tween.TRANS_SINE)
	#tween.set_trans(Tween.TRANS_CIRC)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(%VictoryPanel, "scale", Vector2(1,1), 0.7)
