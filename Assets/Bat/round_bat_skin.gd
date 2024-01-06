extends Node3D

@onready var _animation_tree: AnimationTree = %AnimationTree
@onready var _hurt_shot_path: String = "parameters/HurtShot/request"

@onready var MeshOverride: StandardMaterial3D:
	set(value):
		get_node("RoundBat/Armature/Skeleton3D/Bat").set("surface_material_override/0", value)

## Play a OneShot hurt animation.
## This animation is played in paralel with other states.
func hurt():
	_animation_tree.set(_hurt_shot_path, true)
