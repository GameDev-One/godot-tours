extends "res://addons/godot_tours/core/tour.gd"

## A minimal reproduction of the Godot Tours plugin.

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

func _build() -> void:
	 # Set editor state according to the tour's needs.
	queue_command(func reset_editor_state_for_tour():
		interface.canvas_item_editor_toolbar_grid_button.button_pressed = false
		interface.canvas_item_editor_toolbar_smart_snap_button.button_pressed = false
		interface.bottom_button_output.button_pressed = false
	)
	
	Steps0000Intro()
	#...
	Steps9999Conclusion()
	

func Steps0000Intro() -> void:
	# 0010: introduction
	context_set_2d()
	scene_open(ProjectSettings.get_setting("application/run/main_scene"))
	bubble_move_and_anchor(interface.base_control, Bubble.At.CENTER)
	bubble_set_avatar_at(Bubble.AvatarAt.CENTER)
	bubble_set_title("WELCOME TO <INSERT TOPIC/CONCEPT>")
	bubble_add_text([
		"[center]In this tutorial, you take your first steps into understanding [b]<INSERT TOPIC/CONCEPT>[/b].[/center]",
		"[center][b]Let's get started![/b][/center]",
		])
	queue_command(bubble.avatar.do_wink)
	complete_step()
	pass


func Steps9999Conclusion() -> void:
	context_set_2d()
	bubble_move_and_anchor(interface.main_screen)
	bubble_set_avatar_at(Bubble.AvatarAt.CENTER)
	bubble_set_avatar_happy()
	bubble_set_title("TUTORIAL COMPLETE")
	bubble_add_text([
		"[center]Congratulations on completing the Tutorial![/center]",
		"[center]You've taken a significant step in mastering[/center]", 
		"[center][font_size=24][b]<INSERT TOPIC/CONCEPT>[/b][/font_size][/center]", 
	])
	complete_step()
	
	context_set_2d()
	bubble_move_and_anchor(interface.main_screen)
	bubble_set_avatar_at(Bubble.AvatarAt.CENTER)
	bubble_set_avatar_happy()
	bubble_set_title("DONT STOP NOW")
	bubble_add_text([
		"Remember, practice is key to reinforcing your skills.",
		"Don't hesitate to revisit any section if needed, and feel free to explore more advanced features as you become more comfortable." , 
	])
	complete_step()

#endregion

