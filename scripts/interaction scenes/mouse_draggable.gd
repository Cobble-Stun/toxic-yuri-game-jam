extends Button
##Use pixels
@export var maxCursorDistanceRadius: float = 200
@export var horizontalImages: Array[Texture2D]
@export var verticalImages: Array[Texture2D]
@export var topLeftToBotRightImages: Array[Texture2D]
@export var botLeftToTopRightImages: Array[Texture2D]
@export var neutralImage: Texture2D
@onready var cursor = get_tree().get_first_node_in_group("Cursor")
@onready var sprite = get_parent()
var distanceToOrigin = Vector2.ZERO
var coordinatesMatrix: Array[Vector2]
var horizontalValues = []
var verticalValues = []
var topLeftToBotRightValues = []
var botLeftToTopRightValues = []
var held = false

func _ready() -> void:
	#get values
	for x in horizontalImages.size()+1:
		horizontalValues.append((x-horizontalImages.size()/2))
	for y in verticalImages.size()+1:
		verticalValues.append((y-verticalImages.size()/2))
	for nlin in topLeftToBotRightImages.size()+1:
		topLeftToBotRightValues.append(nlin-topLeftToBotRightImages.size()/2)
	for lin in botLeftToTopRightImages.size()+1:
		botLeftToTopRightValues.append(lin-botLeftToTopRightImages.size()/2)
		
	#make pixels
	for index in horizontalValues.size():
		if horizontalValues[index] == 0:
			pass
		else:
			horizontalValues[index] = maxCursorDistanceRadius/horizontalValues[horizontalImages.size()]*horizontalValues[index]
	for index in verticalValues.size():
		if verticalValues[index] == 0:
			pass
		else:
			verticalValues[index] = maxCursorDistanceRadius/verticalValues[verticalImages.size()]*verticalValues[index]
			
	#coordinates
	for x in horizontalValues:
		for y in verticalValues:
			if abs(x) == abs(y):
				coordinatesMatrix.append(Vector2(x, y))
			elif x == 0 or y == 0:
				coordinatesMatrix.append(Vector2(x, y))
			else: 
				pass
	
func _input(event: InputEvent) -> void:
	if cursor.state != cursor.held:
		return
	if event is InputEventMouseMotion:
		distanceToOrigin.x += event.relative.x
		distanceToOrigin.y += event.relative.y
		
func _process(delta: float) -> void:
	distanceToOrigin.x = clamp(distanceToOrigin.x, -maxCursorDistanceRadius, maxCursorDistanceRadius)
	distanceToOrigin.y = clamp(distanceToOrigin.y, -maxCursorDistanceRadius, maxCursorDistanceRadius)
	
	if !held:
		distanceToOrigin = lerp(distanceToOrigin, Vector2.ZERO, delta*40)
		if abs(distanceToOrigin.length()) < maxCursorDistanceRadius/10:
			sprite.texture = neutralImage
			return
		if sprite.texture == neutralImage:
			return
		
	var closestPoint = get_closest_point_to_mouse()
	for coordinate in coordinatesMatrix:
		if coordinate == closestPoint:
			if coordinate.x != 0 and coordinate.y == 0:
				pick_images_from_axis(horizontalImages, horizontalValues, coordinate.x, 0)
			elif coordinate.x == 0 and coordinate.y != 0:
				pick_images_from_axis(verticalImages, verticalValues, coordinate.y, 0)
			elif coordinate.x < 0 and coordinate.y < 0 or coordinate.x > 0 and coordinate.y > 0:
				pick_images_from_axis(topLeftToBotRightImages, topLeftToBotRightValues, coordinate, 1)
			elif coordinate.x < 0 and coordinate.y > 0 or coordinate.x > 0 and coordinate.y < 0:
				pick_images_from_axis(botLeftToTopRightImages, botLeftToTopRightValues, coordinate, 2)
				
func get_closest_point_to_mouse() -> Vector2:
	var closest_point = Vector2.ZERO
	var shortest_distance = INF
	
	for point in coordinatesMatrix:
		var distance = distanceToOrigin.distance_to(point)
		
		if distance < shortest_distance:
			shortest_distance = distance
			closest_point = point
	return closest_point
	
func pick_images_from_axis(axisImages: Array[Texture2D], axisValues:Array, axis, diagonal: int):
	for index in axisValues.size():
		if diagonal == 0:
			if round(axis) == round(maxCursorDistanceRadius/axisValues[axisImages.size()]*axisValues[index]):
				if index > axisValues.size()/2:
					sprite.texture = axisImages[index-1]
				else:
					sprite.texture = axisImages[index]
		elif diagonal == 1:
			if round(axis.x) == round(maxCursorDistanceRadius/axisValues[axisImages.size()]*axisValues[index]) \
			and round(axis.y) == round(maxCursorDistanceRadius/axisValues[axisImages.size()]*axisValues[index]):
				if index > axisValues.size()/2:
					sprite.texture = axisImages[index-1]
				else:
					sprite.texture = axisImages[index]
		elif diagonal == 2:
			if round(axis.x) == round(maxCursorDistanceRadius/axisValues[axisImages.size()]*axisValues[index]) \
			and round(axis.y) == round(-maxCursorDistanceRadius/axisValues[axisImages.size()]*axisValues[index]):
				if index > axisValues.size()/2:
					sprite.texture = axisImages[index-1]
				else:
					sprite.texture = axisImages[index]
	
func _on_button_down() -> void:
	get_viewport().warp_mouse(global_position+size/2)
	cursor.state = cursor.held
	held = true
	
func _on_button_up() -> void:
	cursor.state = cursor.normal
	held = false
	
func _on_mouse_entered() -> void:
	if cursor.state == cursor.normal:
		cursor.state = cursor.hover
	
func _on_mouse_exited() -> void:
	if cursor.state == cursor.hover:
		cursor.state = cursor.normal
