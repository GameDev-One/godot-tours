@icon("res://Assets/Brain.svg")
extends Node

## Unstructed Ai that controls how the Bat moves along a specified path.
##
## Path3D will generate several points that define the path.
## This is useful for when the path uses curves instead of straight lines.
## See https://docs.godotengine.org/en/stable/classes/class_curve3d.html#class-curve3d for more info.
##
## [codeblock]
## TODO: 
## -[] Task 1
## -[x] Task 2
## [/codeblock]

#region SIGNALS
#endregion

#region ENUMS
#endregion

#region CONSTANTS
#endregion

#region EXPORT VARS
#endregion

#region PUBLIC VARS
#endregion

#region PRIVATE VARS
var _Bat: CharacterBody3D
var _Path: Array
var _TargetPathIndex: int = -1
#endregion

#region ONREADY VARS
#endregion

#region PUBLIC METHODS
#endregion

#region PRIVATE METHODS
func _physics_process(delta):
	if _Bat.PATH_MODE == "None":
		return
	
	
	# Set the next destination if close to current destination
	if _Bat.position.distance_to(_Path[_TargetPathIndex]) < 0.05:
		_TargetPathIndex = (_TargetPathIndex + 1) % _Path.size()
	
	# Recalculate direction and velocity to the target destination
	var _Direction: Vector3 = _Bat.position.direction_to(_Path[_TargetPathIndex])
	_Bat.velocity = _Direction * _Bat.MovementSpeed
	
	# Move the character
	_Bat.move_and_slide()
	pass
	


func _ready():
	# Wait for the owner of the scene to be ready before accessing sibling nodes.
	# This will guarentee those Nodes are ready to be accessed
	await owner.ready
	
	# Store the owner for use later
	_Bat = owner
	
	# Get all baked points from the Path3D Node.
	# Path3D will generate several points that define the path. 
	# This is useful for when the path uses curves instead of straight lines.
	# See https://docs.godotengine.org/en/stable/classes/class_curve3d.html#class-curve3d for more info.
	if not _Bat.PATH_MODE == "None":
		_Path = owner.get_node(_Bat.PATH_MODE + "Path").curve.get_baked_points()
pass
#endregion

