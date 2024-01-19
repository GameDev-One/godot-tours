extends Node

## Unstructed AI that controls how the Bat moves along a specified path.
##
## Path3D will generate several points that define the path.
## This is useful for when the path uses curves instead of straight lines.
## See https://docs.godotengine.org/en/stable/classes/class_curve3d.html#class-curve3d for more info.
##

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
	# Do nothing if the Path Mode is 'None'
	
	
	# Set the next path point if close to current point
	
	
	# Recalculate direction and velocity to the current point
	
	
	# Move the character
	
	
	pass


func _ready():
	# Wait for the owner of the scene to be ready before accessing its children.
	# This will guarentee children Nodes have been initialized properly before
	# accessing methods and variables
	
	
	# Store the owner for use later
	
	
	# Get all baked points from the Path3D Node and convert them to global coordinates.
	# Path3D will generate several points that define a path in local space. 
	# This is useful for when the path uses curves instead of straight lines.
	# See https://docs.godotengine.org/en/stable/classes/class_curve3d.html#class-curve3d for more info.
	
	
		# Convert to global coordinates
		
	
	pass
#endregion

