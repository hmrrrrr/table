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



func _physics_process(delta):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_player_exit_room(side):
	score += 1
	$Label.text=str(score)
	walls[side].translation.y = 0
	curRoom = rooms[randi()%len(rooms)]
	
	while roomData[curRoom][0] != oppside[side]:
		curRoom = rooms[randi()%len(rooms)]
	
	roomInst.queue_free()
	roomInst = curRoom.instance()
	add_child(roomInst)
	
	walls[roomData[curRoom][1]].translation.y = -192
	
	Global.player.newRoom(sideStart[oppside[side]])


func _on_player_die():
	get_tree().change_scene_to(reload)
