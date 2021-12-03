extends MeshInstance

export(Array,NodePath) var points
var curPoint = 0
var pos
# Called when the node enters the scene tree for the first time.
func _ready():
	print('ready')


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Timer_timeout():
	curPoint = (curPoint+1)%(len(points))
	$Tween.interpolate_property(self,'translation',translation,get_node(points[curPoint]).translation,0.5,Tween.EASE_IN_OUT)
	$Tween.start()
