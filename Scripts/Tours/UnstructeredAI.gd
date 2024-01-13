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
	
	_Steps0000Intro()
	_Steps0100FirstLookBatScene()
	_Steps0200StarPathForBat()
	_Steps0300UnstructedAICode()
	_Steps9999Conclusion()
	

func _Steps0000Intro() -> void:
	# 0010: Introduction
	context_set_3d()
	scene_open(ProjectSettings.get_setting("application/run/main_scene"))
	bubble_move_and_anchor(interface.base_control, Bubble.At.CENTER)
	bubble_set_avatar_at(Bubble.AvatarAt.CENTER)
	bubble_set_title("WELCOME TO UNSTRUCTURED AI TUTORIAL")
	bubble_add_text([
		"[center]In this tutorial, you take your first steps into understanding [b]AI Behaviors[/b] using the Godot Game Engine.[/center]",
		"[center]We'll walk the process of creating your [b]Unstructured AI[/b] that you can use for any future projects.[/center]",
		"[center][b]Let's get started![/b][/center]",
		])
	queue_command(bubble.avatar.do_wink)
	complete_step()
	
	# 0011: Disclaimer
	bubble_move_and_anchor(interface.base_control, Bubble.At.CENTER)
	bubble_set_avatar_at(Bubble.AvatarAt.CENTER)
	bubble_set_title("DISCLAIMER")
	bubble_add_text([
		"Before we start understand this tutorial is all about diving into the cool stuff in Godot, but we're assuming you already have a bit of a handle on [b]Scenes, Nodes, and GDScript.[/b]",
		"If those terms sound familiar to you, awesome! You're in the right place.",
		"But if you're scratching your head and wondering what [b]Scenes, Nodes, and GDScript[/b] are, no worries!",
		"Taking a few minutes to explore introductory materials provided by the [url=https://docs.godotengine.org/en/stable/getting_started/introduction/key_concepts_overview.html]official Godot documentation[/url] or completing beginner-level tutorials before proceeding with this content will get you up to speed.",
		"Happy learning, and let's dive in!"
		])
	complete_step()
	
	# 0020: Look at game you'll make
	highlight_controls([interface.run_bar_play_button], true)
	bubble_move_and_anchor(interface.canvas_item_editor, Bubble.At.TOP_RIGHT)
	bubble_set_avatar_at(Bubble.AvatarAt.LEFT)
	bubble_set_title("TRY THE GAME")
	bubble_add_text(
		["When a project is first opened in Godot, we land on the [b]Game Scene[/b]. It is the entry point of a Godot game.",
		"Click the play icon in the top right of the editor to run the Godot project.",
		"Take a sometime to get familiar with World inside the game using either the keyboard or joypad controls.",
		"Once you feel familiarized, press [b]ESC[/b] on your keyboard to stop the game.",
		])
	bubble_add_task_press_button(interface.run_bar_play_button)
	complete_step()
	
	# 0030: Notice the Bats
	bubble_move_and_anchor(interface.canvas_item_editor, Bubble.At.CENTER)
	bubble_set_avatar_at(Bubble.AvatarAt.CENTER)
	bubble_set_title("Notice the Bats?")
	bubble_add_text(
		["Great job!",
		"As you were getting familiar with the game world, did you notice the bats in the cave?",
		"These bats are going to be the focus of our Unstructured AI for this tutorial.",
		"<INSERT LOOPING VIDEO OF BATS HERE>"
		])
	complete_step()


func _Steps0100FirstLookBatScene() -> void:
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
		"Uncollapse the Enemies Node to reveal all of the Bats in the Scene Dock.",
		"Then select the [code]Open in Editor Icon[/code] next to 'Bat0' to open the Bat Scene."
	])
	bubble_add_task(
		"Go to the Bat Scene",
		1,
		func task_open_bat_scene(task: Task) -> int:
			var scene_root: Node = EditorInterface.get_edited_scene_root()
			if scene_root == null:
				return 0
			return 1 if scene_root.name == "Bat" else 0
	)
	highlight_controls([interface.scene_dock], true)
	queue_command(func bottom_output_close():
		interface.bottom_button_output.button_pressed = false
	)
	queue_command(func show_nodes():
		for node in EditorInterface.get_edited_scene_root().get_children():
			if node.has_method("show"):
				node.show()
		)
	complete_step()
	
	# 0120: Look at the Bat
	context_set_3d()
	
	highlight_controls([interface.spatial_editor])
	bubble_move_and_anchor(interface.spatial_editor, Bubble.At.BOTTOM_RIGHT)
	bubble_set_avatar_at(Bubble.AvatarAt.LEFT)
	bubble_set_title("Look how cute that bat be!")
	bubble_add_text([
		"The bat is a creature with a straightforward mindset, comprehending only how to navigate its existence within the game world.",
		"This simplicity makes it an ideal candidate for our [b]Unstructured AI[/b], as the bat can remain focused solely on its behavioral aspects without the need to consider broader aspects of the game environment.",
		"Before delving into the implementation of the AI, let's break down the components of the Bat Scene."
		])
	queue_command(func spatial_editor_reset_camera():
		interface.spatial_editor_surface.gui_input.emit(EVENTS.f)
		interface.spatial_editor_surface.gui_input.emit(EVENTS.num_1)
		interface.spatial_editor_cameras[0].set_orthogonal(7, interface.spatial_editor_cameras[0].near, interface.spatial_editor_cameras[0].far)
		)
	complete_step()
	
	# 0130: Scene Breakdown: Bat
	highlight_controls([interface.spatial_editor])
	highlight_scene_nodes_by_path(["Bat"])
	bubble_set_title("Scene Breakdown: Bat")
	bubble_add_text([
		"Bat is a CharacterBody3D node that will allow the Bat to float in 3D space while giving us control over how it moves using Godot's Physics system."
		])
	queue_command(func show_nodes():
		for node in EditorInterface.get_edited_scene_root().get_children():
			if node.has_method("show"):
				node.show()
		)
	complete_step()
	
	# 0131: Scene Breakdown: Description
	highlight_controls([interface.spatial_editor])
	highlight_scene_nodes_by_path(["Bat/Description"])
	bubble_set_title("Scene Breakdown: Description")
	bubble_add_text([
		"Description is a Label3D node that shows useful information about the Bat to the player in-game."
		])
	queue_command(func hide_nodes():
		for node in EditorInterface.get_edited_scene_root().get_children():
			if node.has_method("hide"):
				node.hide()
		EditorInterface.get_edited_scene_root().get_node("Description").show()
		)
	complete_step()
	
	# 0132: Scene Breakdown: AI
	highlight_controls([interface.spatial_editor])
	highlight_scene_nodes_by_path(["Bat/AI"])
	bubble_set_title("Scene Breakdown: AI")
	bubble_add_text([
		"AI is a Node to control all other sibling Nodes for the Unstructured AI.",
		"We will be adding a script to this node later."
		])
	queue_command(func hide_nodes():
		for node in EditorInterface.get_edited_scene_root().get_children():
			if node.has_method("hide"):
				node.hide()
		)
	complete_step()
	
	# 0133: Scene Breakdown: Model
	highlight_controls([interface.spatial_editor])
	highlight_scene_nodes_by_path(["Bat/Model"])
	bubble_set_title("Scene Breakdown: Model")
	bubble_add_text([
		"Model is a Node3D that contains the 3D Model and Animations of the Bat.",
		])
	queue_command(func hide_nodes():
		for node in EditorInterface.get_edited_scene_root().get_children():
			if node.has_method("hide"):
				node.hide()
		EditorInterface.get_edited_scene_root().get_node("Model").show()
		)
	complete_step()
	
	# 0134: Scene Breakdown: Collision
	highlight_controls([interface.spatial_editor])
	highlight_scene_nodes_by_path(["Bat/Collision"])
	bubble_set_title("Scene Breakdown: Collision")
	bubble_add_text([
		"Collision is a CollisionShape3D node that allows the Bat to interact with the 3D World.",
		])
	queue_command(func hide_nodes():
		for node in EditorInterface.get_edited_scene_root().get_children():
			if node.has_method("hide"):
				node.hide()
		EditorInterface.get_edited_scene_root().get_node("Collision").show()
		)
	complete_step()
	
	# 0135: Scene Breakdown: Path
	highlight_controls([interface.spatial_editor])
	highlight_scene_nodes_by_path(["Bat/StarPath", "Bat/OvalPath"])
	bubble_set_title("Scene Breakdown: Paths")
	bubble_add_text([
		"Additionally, 'StarPath' and 'OvalPath' are Path3D nodes employed to define predetermined routes for the bat to traverse.",
		])
	queue_command(func hide_nodes():
		for node in EditorInterface.get_edited_scene_root().get_children():
			if node.has_method("hide"):
				node.hide()
		EditorInterface.get_edited_scene_root().get_node("StarPath").show()
		EditorInterface.get_edited_scene_root().get_node("OvalPath").show()
		)
	complete_step()
	
	# 0140: AI and Paths
	highlight_controls([interface.spatial_editor])
	highlight_scene_nodes_by_path(["Bat/AI","Bat/StarPath", "Bat/OvalPath"])
	bubble_set_title("Scene Breakdown: Unstructured AI and Paths")
	bubble_add_text([
		"Through a combination of the AI and Path nodes, we will to design the Unstructured AI that the bat will follow.",
		])
	queue_command(func show_nodes():
		for node in EditorInterface.get_edited_scene_root().get_children():
			if node.has_method("show"):
				node.show()
		)
	complete_step()


func _Steps0200StarPathForBat() -> void:
	# 0200: Design StarPath
	highlight_controls([interface.inspector_editor])
	highlight_scene_nodes_by_path(["Bat/StarPath"])
	bubble_move_and_anchor(interface.spatial_editor, Bubble.At.CENTER)
	bubble_set_title("Design StarPath")
	bubble_add_text([
		"Click on the StarPath and lets take a look at its components in the Inspector dock",
		])
	bubble_add_task(
		"Select StarPath Node.",
		1,
		func select_starpath_node(task: Task) -> int:
			var selected_node = EditorInterface.get_selection().get_selected_nodes()[0]
			return 1 if selected_node.name == "StarPath" else 0
	)
	complete_step()
	
	# 0210: Curve3D Resource
	highlight_inspector_properties(["curve"])
	highlight_scene_nodes_by_path(["Bat/StarPath"])
	bubble_set_title("Curve3D Resource")
	bubble_add_text([
		"The Curve3D is a resource that describes a Bézier curve in 3D space.",
		"We will use it to give shape to our path by providing it points to follow.",
		])
	bubble_add_task(
		"Select the Curve3D resource",
		1,
		func open_curve3d_resource(task: Task) -> int:
			var button = find_editor_inspector_property_button("curve")[0]
			if button == null:
				return 0
			return 1 if button.button_pressed == true else 0
	)
	complete_step()
	
	# 0220: Add a Point to Curve3D
	highlight_inspector_properties(["curve"])
	bubble_add_text([
		"Once we've defined our points the Curve3D resource will pre-calculate additonal points to create the Beizer curve.",
		"This is extrememly useful when our path needs to be curved and we will dig into that later in this tutorial.",
		"[indent][b]1. Uncollaspe Points and Select Add Element to add a point.[/b][/indent]",
	])
	bubble_add_task(
		"Enter [code](-2, 0, 0)[/code] for the Position.",
		1,
		func add_point_to_starpath_node(task: Task) -> int:
			var selected_node = EditorInterface.get_selection().get_selected_nodes()[0].curve
			return 1 if selected_node.get("point_0/position") == Vector3(-2, 0, 0) else 0
	)
	complete_step()
	
	# 0230: Notice path being formed in the Spatial Editor
	highlight_controls([interface.spatial_editor])
	bubble_move_and_anchor(interface.spatial_editor, bubble.At.BOTTOM_RIGHT)
	bubble_add_text([
		"As we add more Points to StarPath we should see the path being generated in the Spatial Editor."
	])
	complete_step()
	
	# 0240: Add Remaining Points
	highlight_inspector_properties(["curve"])
	bubble_add_text([
		" Add Elements for these points to the Curve3D:"
	])
	bubble_add_task(
		"Add Point (0,3,0)",
		1,
		func add_remaining_points_to_curve3d(task: Task) -> int:
			var selected_node = EditorInterface.get_selection().get_selected_nodes()[0].curve
			return 1 if selected_node.get("point_1/position") == Vector3(0, 3, 0) else 0
	)
	bubble_add_task(
		"Add Point (2,0,0)",
		1,
		func add_remaining_points_to_curve3d(task: Task) -> int:
			var selected_node = EditorInterface.get_selection().get_selected_nodes()[0].curve
			return 1 if selected_node.get("point_2/position") == Vector3(2, 0, 0) else 0
	)
	bubble_add_task(
		"Add Point (-2,2,0)",
		1,
		func add_remaining_points_to_curve3d(task: Task) -> int:
			var selected_node = EditorInterface.get_selection().get_selected_nodes()[0].curve
			return 1 if selected_node.get("point_3/position") == Vector3(-2, 2, 0) else 0
	)
	bubble_add_task(
		"Add Point (2,2,0)",
		1,
		func add_remaining_points_to_curve3d(task: Task) -> int:
			var selected_node = EditorInterface.get_selection().get_selected_nodes()[0].curve
			return 1 if selected_node.get("point_4/position") == Vector3(2, 2, 0) else 0
	)
	bubble_add_task(
		"Add Point (-2,0,0)",
		1,
		func add_remaining_points_to_curve3d(task: Task) -> int:
			var selected_node = EditorInterface.get_selection().get_selected_nodes()[0].curve
			return 1 if selected_node.get("point_5/position") == Vector3(-2, 0, 0) else 0
	)
	complete_step()
	
	
	# 0230: Notice path being formed in the Spatial Editor
	highlight_controls([interface.spatial_editor])
	bubble_move_and_anchor(interface.spatial_editor, bubble.At.BOTTOM_RIGHT)
	bubble_set_title("STAR PATH CREATED!")
	bubble_add_text([
		"Well done! We've successfuly designed our first Path3D.",
		"Now we can add the code to the AI Node to have the Bat follow this path."
	])
	queue_command(func spatial_editor_reset_camera():
		interface.spatial_editor_surface.gui_input.emit(EVENTS.f)
		interface.spatial_editor_surface.gui_input.emit(EVENTS.num_1)
		interface.spatial_editor_cameras[0].set_orthogonal(7, interface.spatial_editor_cameras[0].near, interface.spatial_editor_cameras[0].far)
		)
	complete_step()
	pass


func _Steps0300UnstructedAICode() -> void:
	# 0300: AI Node Introduction
	highlight_scene_nodes_by_path(["Bat","Bat/AI"])
	bubble_move_and_anchor(interface.canvas_item_editor, Bubble.At.TOP_LEFT)
	bubble_set_avatar_at(Bubble.AvatarAt.CENTER)
	bubble_set_title("Open the AI script")
	bubble_add_text([
		"The seperation of the AI logic from the top-level Node is a common practice in the game industry.",
		"The Bat Node is responsible for controlling access its internal components for objects OUTSIDE of the Bat Scene.",
		"While the AI Node will be responsible for any interactions between the components INSIDE the Bat scene.",
		"See [url=https://wikipedia.org/wiki/Separation_of_concerns#:~:text=In%20computer%20science%2C%20separation%20of,code%20of%20a%20computer%20program]'Deisgn Principle - Separation of Concerns'[/url] for more info."
	])
	complete_step()
	
	highlight_scene_nodes_by_path(["Bat/AI"])
	bubble_add_task(
		"Open the AI script.",
		1,
		func(task: Task) -> int:
			if not interface.is_in_scripting_context():
				return 0
			var open_script: String = EditorInterface.get_script_editor().get_current_script().resource_path
			return 1 if open_script == "res://AI/Unstructered/Bat/AI.gd" else 0
	)
	complete_step()
	
	# 0310: AI Code Variables
	highlight_code(25,29)
	bubble_move_and_anchor(interface.inspector_dock, Bubble.At.BOTTOM_RIGHT)
	bubble_set_avatar_at(Bubble.AvatarAt.LEFT)
	bubble_set_title("AI Code Variables")
	bubble_add_text([
		"To be able to have the Bat follow the path we are going to need to store:[code][b][ul]
		A reference to the Bat Node
		A list of all the positions we want to travel along the path
		A index variable for accessing the above list[/ul][/b][/code]",
	])
	complete_step()
	
	# 0320: AI Code 
	highlight_code(56,61)
	bubble_move_and_anchor(interface.inspector_dock, Bubble.At.BOTTOM_RIGHT)
	bubble_set_avatar_at(Bubble.AvatarAt.LEFT)
	bubble_set_title("AI Code Initialize Variables")
	bubble_add_text([
		"Wait for the owner of the scene to be ready before accessing its children. This will guarentee children Nodes have been initialized properly before accessing methods and variables",
	])
	bubble_add_code([
		"await owner.ready",
		])
	bubble_add_task(
		"Copy and Paste Code above to Line 60.",
		1,
		func check_line_in_script(task: Task) -> int:
			var line_number = 60
			var line = EditorInterface.get_script_editor().get_current_script().source_code.get_slice("\n", line_number - 1)
			return 1 if line.contains("await owner.ready") else 0
	)
	complete_step()
	pass


func _Steps9999Conclusion() -> void:
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

func find_editor_inspector_property_button(name: String) -> Array[Node]:
	var b = []
	for child in interface.inspector_editor.find_children("", "EditorProperty", true, false):
		if child.label == name.capitalize():
			b = child.find_children("", "Button", true, false)
	if b.is_empty():
		print("Could not find Editor Propery: " + name)
	return b

func get_all_children(node: Node, level: int = 0):
	var _level: int = level # retains local level property
	for N in node.get_children():
		print(".".repeat(_level) + N.name + " | " + N.get_class())
		if N is EditorProperty:
			print(".".repeat(_level) + "[" + N.label + "]")
		if N.get_child_count() > 0:
			get_all_children(N, _level + 1)
#endregion
