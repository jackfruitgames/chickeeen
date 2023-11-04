extends Node

# -- game score state
var score := 0

# -- game daytime state
const TIME_FACTOR = 1/0.1
const DAY_DURATION := 60 * 1 * TIME_FACTOR  # seconds
const DAWN_TIME := 60 * 0.5 * TIME_FACTOR # seconds

var is_night := false
var dawn_time := DAWN_TIME
var day_duration := DAY_DURATION
