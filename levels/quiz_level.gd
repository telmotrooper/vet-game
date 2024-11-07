extends Control

@export var questions: Array[QuizQuestion]

var current_question: QuizQuestion
var question_counter: int
var score := 0
var mistakes := 0

const base_text := "[center][b]( Acertos:[/b] %d/%d )[/center]"

func _ready() -> void:	
	current_question = questions.pick_random()
	update_question()
	
	%VictoryPanel.visible = false
	%VictoryPanel.scale = Vector2.ZERO
	
	question_counter = len(questions)
	update_text()

func update_question() -> void:
	%Question.text = current_question.text
	
	var answers: Array[String] = [current_question.correct_answer]
	answers.append_array(current_question.wrong_answers)
	answers.shuffle()
	
	var answer_counter = 1
	
	for answer in answers:
		var button = find_child("Answer%d" % answer_counter)
		button.text = "%d. %s" % [answer_counter, answer]
		button.value = answer
		answer_counter += 1

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

func _on_question_answered(value: String) -> void:
	if value == current_question.correct_answer:
		score += 1
	else:
		mistakes += 1
	update_text()
	
	var index = questions.find(current_question)
	questions.pop_at(index)
	
	if len(questions) > 0:
		current_question = questions.pick_random()
		update_question()
	else:
		get_tree().call_group("answers", "set_disabled", true)
		show_victory_panel()
