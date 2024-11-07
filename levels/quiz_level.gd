extends Control

@export var questions: Array[QuizQuestion]

var current_question: QuizQuestion
var question_counter: int
var score := 0
var mistakes := 0

const base_text := "[center][b]( Acertos:[/b] %d/%d )[/center]"

func _ready() -> void:
	current_question = questions.pick_random()
	%Question.text = current_question.text
	
	%VictoryPanel.visible = false
	%VictoryPanel.scale = Vector2.ZERO
	
	update_text()

func update_text() -> void:
	%Score.text = base_text % [score, question_counter]

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
