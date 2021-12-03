extends RigidBody

const speed = 0.5
const jumpHeight = 6.5

export(String) var leftControl
export(String) var rightControl
export(String) var upControl
export(String) var downControl

export(Color) var color

var mouse
var pos
var respawnPos = Vector3(0,0,4)
signal die()
signal exit_room(side)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var contacts = []
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.players.append(self)
	$MeshInstance.get_surface_material(0).albedo_color = color

func newRoom(p):
	pos = get_transform()
	pos.origin = p
	set_transform(pos)
	linear_velocity /= 3
	print(name)
	


func _integrate_forces(state):
	linear_velocity.x += speed*(Input.get_action_strength(rightControl)-Input.get_action_strength(leftControl))
	linear_velocity.z += speed*(Input.get_action_strength(downControl)-Input.get_action_strength(upControl))
	pos = state.get_transform()
	
	if pos.origin.x > 12:
		emit_signal('exit_room','right')
	elif pos.origin.x < -12:
		emit_signal('exit_room','left')
	if pos.origin.z > 8:
		emit_signal('exit_room','down')
	elif pos.origin.z < -8:
		emit_signal('exit_room','up')
	
	
	if pos.origin.y < -10:
		Global.players = []
		emit_signal('die')
		pos.origin = Vector3(respawnPos)
	
	state.set_transform(pos)
	


