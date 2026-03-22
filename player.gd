extends CharacterBody2D


@export var maxSpeed := 500.0
var maxSpeedMod := 500.0
@export var jumpHeight := -540.0
var jumpHeightMod := -540.0
@export var curSpeed := 0.0
@export var dashSpeed := 700.0
var dashSpeedMod := 500
@export var maxJumps := 2
var maxJumpsMod := 2
var jumps = 2
var constJump = false
var stoppable = true
@export var maxDashes := 1
var maxDashesMod := 1
var dashes = 1
var dashing = false
var acceleration = 20
var accelMod = 20
var dir = -1
var stopped = false
var skin = 1
var coyoteTimedOut = false
@export var jumpAdd = 0
@export var jumpMult = 1.0
@export var maxJumpAdd = 0
@export var speedAdd = 0
@export var speedMult = 1.0
@export var dashAdd = 0
@export var dashMult = 1.0
@export var maxDashAdd = 0
@export var accelAdd = 0
@export var grounded_y = position.y
@export var jumpFX : AudioStreamWAV
@export var dashFX : AudioStreamWAV


func _ready() -> void:
	grounded_y = position.y

func _process(_delta: float) -> void:
	match $"Stackable Object".type:
		"none":
			maxSpeed = 500.0
			jumpHeight = -540.0
			maxJumps = 2
			constJump = false
			maxDashes = 1
			dashSpeed = 700.0
			acceleration = 20
		"umbrella":
			maxSpeed = 250.0
			jumpHeight = -650.0
			maxJumps = 3
			constJump = false
			maxDashes = 1
			dashSpeed = 400.0
			acceleration = 250
		"jetpack":
			maxSpeed = 500.0
			jumpHeight = -200.0
			jumps = 1
			constJump = true
			stoppable = true
			maxDashes = 0
			acceleration = 15
		"manhole":
			maxSpeed = 100.0
			jumpHeight = -600.0
			maxJumps = 1
			constJump = false
			maxDashes = 2
			dashSpeed = 300.0
			acceleration = 100
		"divingR":
			maxSpeed = 300.0
			jumpHeight = -800.0
			maxJumps = 1
			constJump = false
			maxDashes = 1
			dashSpeed = 500.0
			acceleration = 20
		"divingL":
			maxSpeed = 300.0
			jumpHeight = -800.0
			maxJumps = 1
			constJump = false
			maxDashes = 1
			dashSpeed = 500.0
			acceleration = 20
	maxSpeedMod = maxSpeed * speedMult + speedAdd
	jumpHeightMod = jumpHeight * jumpMult - jumpAdd
	maxJumpsMod = maxJumps + maxJumpAdd
	dashSpeedMod = dashSpeed * dashMult + dashAdd
	maxDashesMod = maxDashes + maxDashAdd
	accelMod = acceleration + accelAdd
	if stopped and Input.is_action_just_pressed("escape"):
		stopped = false
	if not get_node("/root/Main/UI/Pause Screen").visible:
		if skin == 1:
			if velocity.y < 0:
				$Sprite.animation = "jump-1"
			elif velocity.y > 0:
				$Sprite.animation = "fall-1"
			elif dashing:
				$Sprite.animation = "dash-1"
			elif abs(velocity.x) > 5:
				$Sprite.animation = "walk-1"
			else:
				$Sprite.animation = "neutral-1"
			$Sprite.play()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if velocity.y <= 0:
			velocity += get_gravity() * delta
		else:
			velocity += get_gravity() * delta * 1.1
		$CoyoteTime.start()
	
	if is_on_floor():
		grounded_y = position.y
		jumps = maxJumpsMod
		dashes = maxDashesMod
		coyoteTimedOut = false
	
	# Handle jump.
	if (Input.is_action_just_pressed("jump") or (constJump and not (Input.is_action_pressed("jump") and stoppable))) and jumps>0:
		velocity.y = jumpHeightMod
		jumps -= 1
		if not $CoyoteTime.is_stopped():
			$CoyoteTime.stop()
		$PlayerSound.stream = jumpFX
		$PlayerSound.play()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		curSpeed = move_toward(curSpeed, maxSpeedMod, accelMod)
		if !dashing:
			velocity.x = direction * curSpeed
		else:
			velocity.x = direction * dashSpeedMod
	else:
		velocity.x = move_toward(velocity.x, 0, accelMod)
		
	if Input.is_action_just_pressed("dash") and dashes>0:
		velocity.x = dir * dashSpeed
		dashing = true
		curSpeed = maxSpeed
		$"Dash Timer".start()
		dashes -= 1
		$PlayerSound.stream = dashFX
		$PlayerSound.play()
		
	if velocity.x != 0:
		$Sprite.flip_h = velocity.x > 0
		if velocity.x > 0:
			dir = 1
		else:
			dir = -1
	else:
		curSpeed = 0
	if not stopped and not get_node("/root/Main/UI/Pause Screen").visible:
		move_and_slide()
	else:
		velocity = Vector2(0,0)
	if position.x < 0:
		position.x = 0
	elif position.x > 960:
		position.x = 960
	if position.y < 0 and grounded_y > position.y + 500:
		grounded_y = position.y + 500

func _on_dash_timer_timeout() -> void:
	dashing = false


func _on_main_open_shop() -> void:
	stopped = true


func _on_stack_stack_added() -> void:
	grounded_y = position.y
	$StackCoolDown.start()
	stopped = true

func _on_stack_cool_down_timeout() -> void:
	stopped = false
	stack_cool_down_timeout.emit()
	$StackCoolDown.stop()

signal stack_cool_down_timeout()


func _on_coyote_time_timeout() -> void:
	jumps -= 1
	coyoteTimedOut = true
