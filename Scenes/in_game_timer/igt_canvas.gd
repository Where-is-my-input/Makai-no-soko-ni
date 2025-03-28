extends CanvasLayer
@onready var in_game_timer: Node = $".."
@onready var lbl_igt: Label = $ing_game_timer_control/hbIGT/lblIGT

var noticeBox = 0
var noticeExplanation = ""

func _ready():
	if in_game_timer == null: in_game_timer = get_parent()
	lbl_igt.visible = in_game_timer.showTimer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updateTimer()

func updateTimer():
	lbl_igt.text = "%02d:" % in_game_timer.hours + "%02d:" % in_game_timer.minutes + "%02d." % in_game_timer.seconds + "%03d" % in_game_timer.msec
