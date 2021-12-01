extends RigidBody

const speed = 0.5
const jumpHeight = 6.5

var canJump = false

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
	Global.player = self

func newRoom(p):
	pos = get_transform()
	pos.origin = p
	set_transform(pos)
	linear_velocity /= 3
	


func _integrate_forces(state):
	linear_velocity.x += speed*(Input.get_action_strength("move_right")-Input.get_action_strength("move_left"))
	linear_velocity.z += speed*(Input.get_action_strength("move_down")-Input.get_action_strength("move_up"))
	pos = state.get_transform()
	
	if pos.origin.x > 12:
		emit_signal('exit_room','right')
	elif pos.origin.x < -12:
		emit_signal('exit_room','left')
	if pos.origin.z > 8:
		emit_signal('exit_room','down')
	elif pos.origin.z < -8:
		emit_signal('exit_room','up')
	
	contacts = []
	for i in range(state.get_contact_count()):
		contacts.append(state.get_contact_collider_position(i))
	
	canJump = false
	for i in contacts:
		canJump = i.y <= pos.origin.y+0.01
	
	if pos.origin.y < -10:
		emit_signal('die')
		pos.origin = Vector3(respawnPos)
	
	state.set_transform(pos)
	
func _input(event):
	if event.is_action_pressed("jump") and canJump:
		linear_velocity.y = jumpHeight


