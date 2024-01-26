extends CharacterBody3D

## Controls access to the variables, methods and child nodes OUTSIDE of the Bat Scene thru export variables and public methods

#region SIGNALS
#endregion

#region ENUMS
#endregion

#region CONSTANTS
#endregion

#region EXPORT VARS
## How fast the character moves in the world
@export_range(0, 5) var MovementSpeed: float = 2.0

## Sets the behavior for which pattern the Bat will use to move around the world.
@export_enum("None", "Star", "Oval") var PATH_MODE: String = "None"
#endregion

#region PUBLIC VARS
#endregion

#region PRIVATE VARS
#endregion

#region ONREADY VARS
@onready var Description: Label3D = $Description
#endregion

#region PUBLIC METHODS
func _ready():
	# Display description of the Bat
	Description.text = name + "\nPath Mode: " + PATH_MODE + "\nSpeed: " + str(MovementSpeed)
	pass
#endregion

#region PRIVATE METHODS

#endregion
