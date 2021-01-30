extends Control

onready var scene_tree: = get_tree()
onready var paused_overlay: ColorRect = get_node("PauseOverlay")
onready var score: Label = get_node("Score")
onready var pause_title: Label = get_node("PauseOverlay/Title")

var paused: = false setget set_paused

func _ready():
	PlayData.connect("score_updated", self, "update_interface")
	PlayData.connect("player_die", self, "_on_PlayData_player_died")
	update_interface()

func _on_PlayData_player_died() -> void:
	self.paused = true
	pause_title.text = "You died!"

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.paused = !paused
		scene_tree.set_input_as_handled()

func update_interface():
	score.text = "Score: %s" % PlayData.score

func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	paused_overlay.visible = value
