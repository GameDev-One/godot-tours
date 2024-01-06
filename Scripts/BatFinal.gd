extends CharacterBody3D

## SHORT DESCRIPTION: 

#region SIGNALS
#endregion

#region ENUMS
#endregion

#region CONSTANTS
const BATFINALMATERIAL = preload("res://Resources/BatFinal.material")
#endregion

#region EXPORT VARS
# How fast the character moves in the world
@export_range(0, 5) var MovementSpeed: float = 1.0

# Sets the behavior for which pattern the Bat will use to move around the world.
@export_enum("None", "Diamond", "DoubleLoop", "SideToSide", "Star", "Oval") var PATH_MODE: String = "None"
#endregion

#region PUBLIC VARS
#endregion

#region PRIVATE VARS
#endregion

#region ONREADY VARS
#endregion

#region PUBLIC METHODS
func _ready():
	$Skin.MeshOverride = BATFINALMATERIAL
	pass
#endregion

#region PRIVATE METHODS

#endregion
