extends Node

var player
var dir = Directory.new()
var rooms = []
var roomData
var sideStart = {
	'left': Vector3(-10,1,0),
	'right': Vector3(10,1,0),
	'up': Vector3(0,1,-5.5),
	'down': Vector3(0,1,5.5)
}
func _ready():
	if dir.open('rooms') == OK:
		print('test')
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir():
				rooms.append(load('rooms/'+file_name))
			file_name = dir.get_next()
	rooms.remove(0)

	roomData = {
		rooms[0]: ['left','right'],
		rooms[1]: ['left','up'],
		rooms[2]: ['left','down'],
		rooms[3]: ['right','left'],
		rooms[4]: ['right','up'],
		rooms[5]: ['right','down'],
		rooms[6]: ['up','right'],
		rooms[7]: ['up','left'], 
		rooms[8]: ['up','down'],}
		#rooms[9]: ['down','up'],
		#rooms[10]:['down','right'],
		#rooms[11]:['down','left']
	#}
