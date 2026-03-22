extends Control

var dialogue = [
	"Once Upon a time off the corner of Vancouver and Florida, There was a Raccoon named Jamie",
	"Jamie was a Raccoon who'd often dream of going to the moon, even if the dream itself was lofty",
	"But one day, Jamie while daydreaming found themselves interrupted by someone asking for help",
	"\"Hey! You there! Yes you! I'm currently in the middle of moving my shop and I just have a lot of merchanise that's very cumbersome to move with, and it'd be super nice if you bought something off of me.\" Announced the Rat.",
	"\"Name's Tony by the way. Talkin' Tony is what they call me, cuz I'll talk your ears off with how great my products are!\"",
	"Jamie thought it was a little strange but decided to buy something, asking first, \"So what kind of stuff you got?\"",
	"\"Oh- Plenty Really! Knicknacks, Doodads, Thingamabobs, Whatchamacallits, You name it!\" But... I think I got just the thing for a Raccoon like you!",
	"As Tony then pulls out something from their box.",
	"\"This is a box that constantly creates new things!\" Explained Tony, \"Nothing useful to me, but to you, maybe! I'm trying to move so I'll happily sell this to you for... Hmm... 20 Coins! Deal?\"",
	"I mean, how was Jamie supposed to know he normally sells it for 5?",
	"\"Oh- Uh... Actually- that'd be perfect! I'll take it!\"",
	"\"Perfect! I'll be setting up my shop if you wanna buy more things later!\"",
	"\"Alright, I'll see you around then!\"",
	"I guess it's time to get to climbing!"
]
var sceneCount = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		$"Pause Screen".visible = not $"Pause Screen".visible
	if Input.is_action_just_pressed("advance") and not $"Pause Screen".visible:
		sceneCount += 1
		if sceneCount == dialogue.size():
			get_tree().change_scene_to_file("res://main.tscn")
		else:
			$TextBox/Text.text = dialogue[sceneCount]
			match sceneCount:
				1:
					$Scene1.visible = false
				2:
					$Scene2.visible = false
				3:
					$Scene3.visible = false
				8:
					$Scene4.visible = false
				_:
					pass
