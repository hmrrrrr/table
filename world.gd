extends Spatial

onready var reload = load('world.tscn')
onready var roomInst = $room
var curRoom
onready var walls = {
		'up':$wall1,
		'down':$wall2,
		'right':$wall3,
		'left':$wall4
	}

var rooms = []
var oppside = {'left':'right','up':'down','right':'left','down':'up'}

var sideStart = Global.sideStart

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var roomData={}
var inst
var score = 0
var dir = Directory.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$wall3.translation.y = -192
	rooms = Global.rooms
	roomData = Global.roomData



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_player_exit_room(side):
	score += 1
	$Label.text=str(score)
	walls[side].translation.y = 0
	
	var a = Global.roomMatrixB[Global.sideStart.keys().find(oppside[side])]
	var b = a[randi()%len(a)]
	while len(b) == 0:
		b = a[randi()%len(a)]
	var c = b[randi()%len(b)]
	curRoom = c
	
	roomInst.queue_free()
	roomInst = curRoom.instance()
	add_child(roomInst)
	
	walls[roomData[curRoom][1]].translation.y = -192
	
	for p in Global.players:
		if p is RigidBody:
			p.newRoom(sideStart[oppside[side]])


func _on_player_die():
	if get_tree().change_scene_to(reload):
		pass
