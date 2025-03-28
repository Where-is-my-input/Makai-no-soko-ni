extends Node

var showTimer = false
var timed = false
var time: float = 0.0
var hours: int = 0
var minutes: int = 0
var seconds: int = 0
var msec: int = 0

var paused:bool = false

func _process(delta):
	if paused: return
	time += delta
	msec = fmod(time, 1) * 100
	seconds = fmod(time, 60)
	minutes = fmod(time, 3600) / 60
	hours = floor(time / 60 / 60 / 60)

func resetIGT():
	time = 0.0
	hours = 0
	minutes = 0
	seconds = 0
	msec = 0
extends CanvasLayer
@onready var hours = $Control/hours
@onready var minutes = $Control/minutes
@onready var seconds = $Control/seconds
@onready var miliseconds = $Control/miliseconds
@onready var notices = $notices
@onready var tmr_notice = $notices/tmrNotice
@onready var lbl_notice = $notices/ColorRect/lblNotice

var noticeBox = 0
var noticeExplanation = ""

func _ready():
	notices.visible = false
	Stats.connect("jumpCollected", jumpCollected)
	Stats.connect("dashCollected", dashCollected)
	Stats.connect("grabTutorial", grabTutorial)
	hours.visible = Stats.showTimer
	minutes.visible = Stats.showTimer
	seconds.visible = Stats.showTimer
	miliseconds.visible = Stats.showTimer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updateTimer()

func updateTimer():
	hours.text = "%02d:" % Stats.hours
	minutes.text = "%02d:" % Stats.minutes
	seconds.text = "%02d." % Stats.seconds
	miliseconds.text = "%03d" % Stats.msec

func _on_tmr_notice_timeout():
	if noticeBox == 0:
		lbl_notice.text = noticeExplanation
		noticeBox += 1
		tmr_notice.start(5)
	else:
		notices.visible = false
		noticeBox = 0
