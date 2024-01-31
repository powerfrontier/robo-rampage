extends CharacterBody3D

@export var attack_range:float = 1.5
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
var player: CharacterBody3D
@onready var animation_player = $AnimationPlayer

var provoked: bool = false
var aggro_range: float = 12.0

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _process(_delta: float) -> void:
	if provoked:
		navigation_agent_3d.target_position = player.global_position


func _physics_process(delta: float) -> void:
	var distance = global_position.distance_to(player.global_position)
	if distance < aggro_range:
		provoked = true
	else:
		provoked = false
	if provoked:
		
		if distance <= attack_range:
			animation_player.play("Attack")
		
		var next_position = navigation_agent_3d.get_next_path_position()
		#print(next_position)
		# Add the gravity.
		if not is_on_floor():
			velocity.y -= gravity * delta
		
		var direction = global_position.direction_to(next_position)
		print(direction)

		if direction:
			look_at_target(direction)
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

		move_and_slide()

func look_at_target(direction: Vector3) -> void:
	var adjusted_direction = direction
	adjusted_direction.y = 0
	look_at(global_position + adjusted_direction, Vector3.UP, true)

func attack() -> void:
	print("enemy attack!")
