extends Node
var roomCount = 0
var players = []
var camera
var dir = Directory.new()
var rooms = []
var roomData = {}
var sideStart = {
	'left': Vector3(-10,1,0),
	'right': Vector3(10,1,0),
	'up': Vector3(0,1,-5.5),
	'down': Vector3(0,1,5.5)
}
var roomMatrix
var roomMatrixB
func _ready():
	for _i in range(100):
		rooms.append(0)
	if dir.open('rooms') == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir():
				rooms[int(file_name.substr(4,file_name.find('.')-4))] = load('rooms/'+file_name)
				print('loaded file ',file_name,' as room ',int(file_name.substr(4,file_name.find('.')-4)))
				roomCount += 1
			file_name = dir.get_next()
	
	roomMatrix = [
		#left right up down entrance
		[[],[rooms[4]],[rooms[8]],[]],#left exit
		[[rooms[1]],[],[rooms[7]],[rooms[10]]],#right
		[[rooms[2]],[rooms[5]],[],[rooms[11]]],#up
		[[rooms[3]],[rooms[6]],[rooms[9]],[]],#down
	]
	roomMatrixB = [
		[[],[],[],[]],
		[[],[],[],[]],
		[[],[],[],[]],
		[[],[],[],[]]
	]
	
	for row in range(len(roomMatrix)):
		for col in range(len(roomMatrix[row])):
			for room in roomMatrix[row][col]:
				roomData[room] = [sideStart.keys()[col],sideStart.keys()[row]]
			roomMatrixB[col][row] = roomMatrix[row][col]
