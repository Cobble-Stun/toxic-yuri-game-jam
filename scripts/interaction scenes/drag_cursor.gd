extends Sprite2D

@export var cursorImages: Array[Texture2D]

enum {
	normal,
	hover,
	held
}

var state = normal

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(_delta: float) -> void:
	match state:
		normal:
			texture = cursorImages[0]
		hover:
			texture = cursorImages[1]
		held:
			texture = null
	global_position = get_global_mouse_position()
