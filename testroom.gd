extends Spatial

export(PackedScene) var room
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var walls = {
		'up':$wall1,
		'down':$wall2,
		'right':$wall3,
		'left':$wall4
	}

var inst
# Called when the node enters the scene tree for the first time.
func _ready():
	inst = room.instance()
	add_child(inst)
	for p in Global.players:
		p.newRoom(Global.sideStart[Global.roomData[room][0]])
		p.respawnPos = Global.sideStart[Global.roomData[room][0]]
	walls[Global.roomData[room][1]].translation.y = -192

func _input(event):
	if event.is_action_pressed("reset"):
		for p in Global.players:
			p.newRoom(Global.sideStart[Global.roomData[room][0]])
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
