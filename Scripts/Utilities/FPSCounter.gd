extends RichTextLabel

## SHORT DESCRIPTION: Displays the target and current FPS of the the game

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
#endregion

#region ONREADY VARS
#endregion

#region PUBLIC METHODS
#endregion

#region PRIVATE METHODS
## Called when the node enters the scene tree for the first time.
func _process(delta):
	
	var CurrentFPS: float = Engine.get_frames_per_second()
	
	text = "Current FPS / [color=green]Target FPS[/color]: %.2f / [color=green]%.2f[/color]" % [CurrentFPS, ProjectSettings.get("application/run/max_fps")] 
	pass # Replace with function body.
#endregion

