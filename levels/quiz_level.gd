extends Control

@export var questions: Array[QuizQuestion]

var current_question: QuizQuestion
var question_counter: int
var score := 0

const base_text := "[center][b]( Acertos:[/b] %d/%d )[/center]"

const QUESTION_TIME = 0.75
const QUESTION_INTERVAL = 1.25
const ANSWER_TIME = 0.5
const FADE_TIME = 1.0
const COLOR_TRANSPARENT = Color(1,1,1,0)

func _ready() -> void:
	current_question = questions.pick_random()
	update_question()
	
	%VictoryPanel.visible = false
	%VictoryPanel.scale = Vector2.ZERO
	
	question_counter = len(questions)
	update_text()
	
	for answer in %Answers.get_children():
		answer.set_mouse_filter(MOUSE_FILTER_IGNORE) # Ignore mouse click.
		answer.modulate = COLOR_TRANSPARENT
	
	# If loaded from main, wait for "fade in" to finish before starting animation.
	if get_tree().current_scene is MainScene:
		await get_tree().current_scene.fade_transition.faded_in
	
	var tween = create_tween()
	tween.tween_interval(QUESTION_INTERVAL)
	tween.tween_callback(fade_in_answers)

func fade_in_answers() -> void:
	var tween = create_tween()
	
	for answer in %Answers.get_children():
		tween.tween_callback(func(): answer.set_mouse_filter(MOUSE_FILTER_STOP)) # Allow mouse click.
		tween.tween_property(answer, "modulate", Color.WHITE, ANSWER_TIME)

func fade_out() -> void:
	var tween = create_tween()
		
	for answer in %Answers.get_children():
		answer.set_mouse_filter(MOUSE_FILTER_IGNORE) # Ignore mouse click.
	
	tween.set_parallel(true)
	tween.tween_property(%Question, "modulate", COLOR_TRANSPARENT, FADE_TIME)
	tween.tween_property(%Answers, "modulate", COLOR_TRANSPARENT, FADE_TIME)
	tween.set_parallel(false)
	tween.tween_callback(func():
		update_question()
		fade_in()
	)

func fade_in() -> void:
	for answer in %Answers.get_children():
		answer.modulate = COLOR_TRANSPARENT
	%Answers.modulate = Color.WHITE
	
	var tween = create_tween()
	
	tween.tween_property(%Question, "modulate", Color.WHITE, QUESTION_TIME)
	tween.tween_interval(QUESTION_INTERVAL)
	tween.tween_callback(fade_in_answers)

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
	if score == question_counter: # all correct
		%VictoryPanel.set_stars(3)
	elif score == question_counter - 1: # missed one
		%VictoryPanel.set_stars(2)
	elif score > 0: # at least one correct
		%VictoryPanel.set_stars(1)
	else: # all wrong
		%VictoryPanel.set_stars(0)
	
	%VictoryPanel.show_panel()

func _on_question_answered(value: String) -> void:
	if value == current_question.correct_answer:
		score += 1
	update_text()
	
	var index = questions.find(current_question)
	questions.pop_at(index)
	
	if len(questions) > 0:
		current_question = questions.pick_random()
		fade_out()
	else:
		get_tree().call_group("answers", "freeze")
		show_victory_panel()
