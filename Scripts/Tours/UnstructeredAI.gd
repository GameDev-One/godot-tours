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
	Steps0100FirstLookBatScene()
	#...
	Steps9999Conclusion()
	

func Steps0000Intro() -> void:
	# 0010: Introduction
	context_set_2d()
	scene_open(ProjectSettings.get_setting("application/run/main_scene"))
	bubble_move_and_anchor(interface.base_control, Bubble.At.CENTER)
	bubble_set_avatar_at(Bubble.AvatarAt.CENTER)
	bubble_set_title("WELCOME TO LEVEL OF THOUGHT FROM AI BEHAVIORS - UNSTRUCTURED AI - TUTORIAL")
	bubble_add_text([
		"[center]In this tutorial, you take your first steps into understanding [b]AI Behaviors[/b] using the Godot Game Engine.[/center]",
		"[center]We'll walk the process of creating your own unstructered AI behaviors that you can use for any future projects.[/center]",
		"[center][b]Let's get started![/b][/center]",
		])
	queue_command(bubble.avatar.do_wink)
	complete_step()
	
	# 0020: Look at game you'll make
	highlight_controls([interface.run_bar_play_button], true)
	bubble_move_and_anchor(interface.canvas_item_editor, Bubble.At.TOP_RIGHT)
	bubble_set_avatar_at(Bubble.AvatarAt.LEFT)
	bubble_add_task_press_button(interface.run_bar_play_button)
	bubble_set_title("Try the game")
	bubble_add_text(
		["When a project is first opened in Godot, we land on the [b]Game Scene[/b]. It is the entry point of a Godot game.",
		"Click the play icon in the top right of the editor to run the Godot project.",
		"Take a sometime to get familiar with World inside the game using either the keyboard or joypad controls.",
		"Once you feel familiarized, press [b]ESC[/b] on your keyboard to stop the game.",
		])
	complete_step()
	
	# 0030: Notice the Bats
	bubble_move_and_anchor(interface.canvas_item_editor, Bubble.At.BOTTOM_RIGHT)
	bubble_set_avatar_at(Bubble.AvatarAt.CENTER)
	bubble_set_title("Notice the Bats?")
	bubble_add_text(
		["Great job!",
		"As you were getting familiar with the game world, did you notice the bats in the cave?",
		"These bats are going to be the focus of our unstructured AI behaviors to for this tutorial.",
		"<INSERT LOOPING VIDEO OF BATS HERE>"
		])
	complete_step()


func Steps0100FirstLookBatScene() -> void:
	# 0100: Introduction
	context_set_3d()
	scene_open(ProjectSettings.get_setting("application/run/main_scene"))
	highlight_controls([interface.scene_dock], true)
	bubble_move_and_anchor(interface.canvas_item_editor, Bubble.At.CENTER_LEFT)
	bubble_set_avatar_at(Bubble.AvatarAt.RIGHT)
	bubble_set_title("Open the Bat Scene")
	bubble_add_text(
		["Let's navigate to the Bat Scene to understand how it works.",
		])
	complete_step()
	
	# 0110: Navigate to the Bat Scene
	highlight_scene_nodes_by_path([
		"Game/Enemies",
		"Game/Enemies/Bat0",
		"Game/Enemies/Bat1",
		"Game/Enemies/Bat2",
		"Game/Enemies/Bat3",
		"Game/Enemies/Bat4",
		])
	bubble_add_text([
		"All of the Bats are located under the Enemies Node as children",
		"Uncollapse the Enemies Node to reveal all of the Bats in the Scene Dock.",
		"Then select the [code]Open in Editor Icon[/code] next to 'Bat0' to open the Bat Scene."
	])
	bubble_add_task(
		("Go to the Bat Scene"),
		1,
		func task_open_bat_scene(task: Task) -> int:
			var scene_root: Node = EditorInterface.get_edited_scene_root()
			if scene_root == null:
				return 0
			return 1 if scene_root.name == "Bat" else 0
	)
	queue_command(func debugger_close():
		interface.bottom_button_debugger.button_pressed = false
	)
	complete_step()
	
	# 0120: Look at the Bat
	context_set_3d()
	canvas_item_editor_center_at(Vector2.ZERO)
	canvas_item_editor_zoom_reset()
	highlight_controls([interface.canvas_item_editor])
	bubble_move_and_anchor(interface.inspector_dock, Bubble.At.BOTTOM_RIGHT)
	bubble_set_avatar_at(Bubble.AvatarAt.LEFT)
	bubble_set_title("How about now?")
	bubble_add_text([
		"Look how cute that bat is <3!",
		])
	complete_step()


func Steps9999Conclusion() -> void:
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

