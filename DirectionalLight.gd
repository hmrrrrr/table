extends OmniLight


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if Global.players[0] is RigidBody:
		light_color.h = fmod(light_color.h+(delta)*(Global.players[0].linear_velocity.length()/100),1)
