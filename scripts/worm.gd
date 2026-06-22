extends Line2D
@export var segment_length: float = 5.0
@export var max_points: int = 25
@export var start_thickness: float = 40.0
@export var end_thickness: float = 0.0
var collected = 0
var collision_shapes: Array[CollisionShape2D] = []
var mousePos = Vector2.ZERO
var dead = false

func _ready():
	collected = Globals.wormCollectableAmount
	update_worm_length()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if points.size() < 2:
		points = PackedVector2Array([Vector2.ZERO, Vector2.ZERO])
	setup_collisions()

func setup_collisions():
	for shape in collision_shapes:
		if is_instance_valid(shape):
			shape.queue_free()
	collision_shapes.clear()
	for i in points.size() - 1:
		var new_shape = CollisionShape2D.new()
		$CharacterBody2D.add_child(new_shape)
		var capsule = CapsuleShape2D.new()
		new_shape.shape = capsule
		collision_shapes.append(new_shape)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mousePos += event.relative

func _physics_process(delta):
	if dead:
		return

	var pts: PackedVector2Array = points

	pts[0] = mousePos

	for i in range(1, pts.size()):
		var target_pos = pts[i - 1]
		var current_pos = pts[i]
		if current_pos.distance_to(target_pos) > segment_length:
			var direction = current_pos.direction_to(target_pos)
			pts[i] = target_pos - (direction * segment_length)

	if pts.size() > max_points:
		pts.resize(max_points)
	elif pts.size() < max_points and pts.size() > 0:
		var last_point = pts[pts.size() - 1]
		var to_mouse = last_point.direction_to(mousePos)
		var new_point = last_point - (to_mouse * segment_length)
		pts.append(new_point)
		points = pts
		setup_collisions()
		return  

	points = pts
	update_collision_positions()

func update_collision_positions():
	for i in collision_shapes.size():
		if i < points.size() - 1:
			var shape_node = collision_shapes[i]
			var capsule = shape_node.shape as CapsuleShape2D
			if not capsule: continue
			var p1 = points[i]
			var p2 = points[i + 1]
			shape_node.global_position = (p1 + p2) / 2.0
			shape_node.rotation = p1.angle_to_point(p2) + PI / 2
			var t = float(i) / float(points.size() - 1)
			var current_width = lerp(start_thickness, end_thickness, t)
			var dist = p1.distance_to(p2)
			capsule.radius = current_width / 2.0
			capsule.height = dist + current_width

func collect_thing():
	collected += 1
	update_worm_length()
	
func update_worm_length():
	segment_length = 5.0 + collected * 0.5
