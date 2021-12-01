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
	Global.player.newRoom(Global.sideStart[Global.roomData[room][0]])
	Global.player.respawnPos = Global.sideStart[Global.roomData[room][0]]
	walls[Global.roomData[room][1]].translation = -192

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
