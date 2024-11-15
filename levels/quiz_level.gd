extends Control

@export var questions: Array[QuizQuestion]

@export_group("Styles")
@export var correct_answer: StyleBox
@export var wrong_answer: StyleBox

var current_question: QuizQuestion
var question_counter: int
var score := 0
var question_answered := false

var check_mark_texture := "res://assets/check_solid.svg"
var x_mark_texture := "res://assets/xmark_solid.svg"

const base_text := "[center][b]( Acertos:[/b] %d/%d )[/center]"
const QUESTION_TIME = 0.75
const QUESTION_INTERVAL = 1.25
const ANSWER_TIME = 0.5
const FADE_TIME = 1.0
const COLOR_TRANSPARENT = Color(1,1,1,0)

signal faded_out

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
	question_answered = false
	var tween = create_tween()
	
	for answer in %Answers.get_children():
		tween.tween_callback(func():
			# Only allow mouse click if current question hasn't been answered yet.
			if not question_answered:
				answer.set_mouse_filter(MOUSE_FILTER_STOP)
		)
		tween.tween_property(answer, "modulate", Color.WHITE, ANSWER_TIME)

func fade_out() -> void:
	var tween = create_tween()
		
	for answer in %Answers.get_children():
		answer.set_mouse_filter(MOUSE_FILTER_IGNORE) # Ignore mouse click.
	
	tween.set_parallel(true)
	tween.tween_property(%Question, "modulate", COLOR_TRANSPARENT, FADE_TIME)
	tween.tween_property(%Answers, "modulate", COLOR_TRANSPARENT, FADE_TIME)
	tween.set_parallel(false)
	tween.tween_callback(faded_out.emit)

func fade_in() -> void:
	for answer in %Answers.get_children():
		answer.release_focus() # If button was clicked before, release focus.
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
		button.remove_theme_stylebox_override("normal")
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

func _on_question_answered(button: Button, value: String) -> void:
	question_answered = true
	
	# Disable mouse temporarily for all "answer" buttons.
	for answer in %Answers.get_children():
		answer.set_mouse_filter(MOUSE_FILTER_IGNORE)
	
	# Paint correct and wrong answers.
	if value == current_question.correct_answer:
		button.add_theme_stylebox_override("normal", correct_answer)
		
		add_check_mark(button, func():
			score += 1
			update_text()
		)
	else:
		button.add_theme_stylebox_override("normal", wrong_answer)
		add_x_mark(button)
		for answer in %Answers.get_children():
			if answer.value == current_question.correct_answer:
				answer.add_theme_stylebox_override("normal", correct_answer)
				break
	
	var index = questions.find(current_question)
	questions.pop_at(index)
	
	# Give some time for the user to check the correct answer.
	await get_tree().create_timer(2.0).timeout
	
	if len(questions) > 0:
		current_question = questions.pick_random()
		fade_out()
		await faded_out
		update_question()
		fade_in()
	else:
		fade_out()
		await faded_out
		get_tree().call_group("answers", "freeze")
		show_victory_panel()

func add_check_mark(button: Button, callback: Callable) -> void:
	var mouse_position := get_viewport().get_mouse_position()
	
	var check_mark := TextureRect.new()
	check_mark.texture = load(check_mark_texture)
	add_child(check_mark) # Already add to the scene tree so we can get the "size".
	
	check_mark.scale = Vector2.ZERO
	check_mark.pivot_offset = check_mark.size / 2
	check_mark.z_index = button.z_index + 2
	
	# Centralize "check mark" on mouse position.
	check_mark.position = mouse_position - (check_mark.size / 2)
	
	# Center of the score label.
	var score_position = %Score.global_position + (%Score.size / 2)
	
	# Compensate size of "check mark" to centralize it on the score label.
	var target_position = score_position - (check_mark.size / 2)
	
	var tween = create_tween()
	tween.tween_property(check_mark, "scale", Vector2.ONE, 0.25)
	tween.tween_interval(1.0)
	tween.tween_property(check_mark, "global_position", target_position, 0.5)
	tween.tween_property(check_mark, "scale", Vector2.ZERO, 0.5)
	tween.tween_callback(check_mark.queue_free)
	tween.tween_callback(callback)

func add_x_mark(button: Button) -> void:
	var mouse_position := get_viewport().get_mouse_position()

	var x_mark := TextureRect.new()
	x_mark.texture = load(x_mark_texture)
	add_child(x_mark) # Already add to the scene tree so we can get the "size".
	
	x_mark.scale = Vector2.ZERO
	x_mark.pivot_offset = x_mark.size / 2
	x_mark.z_index = button.z_index + 2
	
	# Centralize "x mark" on slot.
	x_mark.position = mouse_position - (x_mark.size / 2)
	
	var tween = create_tween()
	tween.tween_property(x_mark, "scale", Vector2.ONE, 0.25)
	tween.tween_interval(1.0)
	tween.tween_property(x_mark, "scale", Vector2.ZERO, 0.5)
	tween.tween_callback(x_mark.queue_free)
