extends KinematicBody

onready var GRAVIDADE = -9.8
onready var velocidade = 10
onready var personagem = get_child(2)
onready var orb = get_child(1)

var onground = false
var sensibilidade = 0.005

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	set_physics_process(true)
	set_process_input(true)

func _gravidade(delta):
	if GRAVIDADE > -9.8:
		GRAVIDADE -= 17.8 * delta
	else:
		GRAVIDADE = -9.8

	move_and_slide(Vector3(0, GRAVIDADE * 50 * delta, 0), Vector3(0, -1, 0), 25.0)

func _move(delta):
	var up =  Input.is_action_pressed("ui_up")
	var shift = Input.is_action_pressed("ui_shift")
	var down = Input.is_action_pressed("ui_down")
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var space = Input.is_action_just_pressed("ui_select")
		
	if up:
		if shift:
			move_and_collide(transform.basis.z * velocidade * -1.30 * delta)
		else:
			move_and_collide(transform.basis.z * velocidade *-1 * delta)
	if down:
		move_and_collide(transform.basis.z * velocidade * delta)
	if right:
		move_and_collide(transform.basis.x * velocidade * delta)
	if left:
		move_and_collide(transform.basis.x * velocidade * -1 * delta)
	if space:
		GRAVIDADE = 10
	
	personagem._olhaPara(orb.get_transform().inverse())
	personagem._update(up, left, right, down, space)

func _physics_process(delta):
	_gravidade(delta)
	_move(delta)

func _input(event):
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x * sensibilidade
