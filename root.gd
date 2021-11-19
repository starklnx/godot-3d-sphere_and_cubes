extends Spatial
# Resource containing my sphere
var sphereNode = preload("res://node_sphere.tscn")
var cubeNode = preload("res://node_cube.tscn")

# In the scene there is a spatial used as a spawn point for the
# new generated spheres
var ballSpawnPoint
var cubeSpawnPoint

var rotation_speed = PI/4

func _ready():
	# Get a reference to the spawn point
	ballSpawnPoint = get_node("sphere")
	# !!!!!!!!!"
	cubeSpawnPoint = get_node("cube")
	# !!!!!!!!!!
	
func _process(delta):
	
	get_input_keyboard(delta)
		
	# New spheres are created when the player press the SPACE BAR
	if(Input.is_action_pressed("ui_select")):
		# Create a new sphere (ball) instance
		var newBall = sphereNode.instance()
		var newCube = cubeNode.instance()
		
		
		if(newBall == null):
			print("Error creating the new ball!")
			
		else:
			# Set position (translation) of the new ball/sphere
			newBall.translation = ballSpawnPoint.translation
			# Translate a little bit away from the original point
			# just to create a nice visual effect
			newBall.translate(Vector3(getRandPos(), getRandPos(), getRandPos()))
			# Add the new sphere to the root scene
			get_parent().add_child(newBall)
	
		
		if(newCube == null):
			print("Error creating the new cube!")
		else:
			# Set position (translation) of the new ball/sphere
			newCube.translation = cubeSpawnPoint.translation
			# Translate a little bit away from the original point
			# just to create a nice visual effect
			newCube.translate(Vector3(getRandPos(), getRandPos(), getRandPos()))
			# Add the new sphere to the root scene
			get_parent().add_child(newCube)
		
func getRandPos():
	return randf()*20-10
	
func get_input_keyboard(delta):
	# Rotate outer gimbal around y axis

	var y_rotation = 0
	if Input.is_action_pressed("ui_right"):
		y_rotation += 1
	if Input.is_action_pressed("ui_left"):
		y_rotation += -1
	rotate_object_local(Vector3.UP, y_rotation * rotation_speed * delta)
	# Rotate inner gimbal around local x axis

	var x_rotation = 0
	if Input.is_action_pressed("ui_up"):
		x_rotation += -1
	if Input.is_action_pressed("ui_down"):
		x_rotation += 1
	$Camera.rotate_object_local(Vector3.RIGHT, x_rotation * rotation_speed * delta)

