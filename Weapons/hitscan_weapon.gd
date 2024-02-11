extends Node3D

@export var fire_rate: float = 14

@onready var cooldown_timer: Timer = $CooldownTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("fire") && cooldown_timer.is_stopped():
		print("weapon fire!!")
		cooldown_timer.start(1.0/fire_rate)
