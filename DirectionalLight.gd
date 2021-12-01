extends OmniLight


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if Global.player:
		light_color.h = fmod(light_color.h+(delta)*(Global.player.linear_velocity.length()/100),1)
