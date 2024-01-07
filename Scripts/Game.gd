extends Node

## The Root Node for the Game 

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

func _IsControllerConnected() -> bool:
	return not Input.get_connected_joypads().is_empty()


func _process(delta):
	# Check if the Pause or Quit Actions are pressed
	if Input.is_action_just_pressed("pause"):
		if _IsControllerConnected():
			$Help/VBoxContainer/MarginContainer/TabContainer.current_tab = 1
		else:
			$Help/VBoxContainer/MarginContainer/TabContainer.current_tab = 0
			
		$Help.visible = !$Help.visible
	elif Input.is_action_pressed("quit"):
		get_tree().quit()
	pass
	
func _ready():
	# Show controller Help Menu if contoller is connected
	if _IsControllerConnected():
		$Help/VBoxContainer/MarginContainer/TabContainer.current_tab = 1
	else:
		$Help/VBoxContainer/MarginContainer/TabContainer.current_tab = 0
	pass
#endregion

