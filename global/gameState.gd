extends Node

# -- game score state
const INITIAL_SCORE := 50
const MAX_EATING_SCORE := 100
var score := INITIAL_SCORE
var level := 1
var eggs := 0

# -- game daytime state
const TIME_FACTOR = 1/0.1
const DAY_DURATION := 60 * 1 * TIME_FACTOR  # seconds
const DAWN_TIME := 60 * 0.5 * TIME_FACTOR # seconds

var is_night := false
var dawn_time := DAWN_TIME
var day_duration := DAY_DURATION


func skip_night():
	is_night = false
	dawn_time = DAWN_TIME
	day_duration = DAY_DURATION


func reset_game():
	score = INITIAL_SCORE
	level = 1
	is_night = false
	dawn_time = DAWN_TIME
	day_duration = DAY_DURATION
	eggs = 0
