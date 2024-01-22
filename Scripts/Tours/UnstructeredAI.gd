extends "res://addons/godot_tours/core/tour.gd"

## A minimal reproduction of the Godot Tours plugin.

#region SIGNALS
#endregion

#region ENUMS
#endregion

#region CONSTANTS
const BATWORLDVIEWPNG := preload("res://Scripts/Tours/Assets/BatWorldView.png")
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
	
	#_Steps0000Intro()
	#_Steps0100FirstLookBatScene()
	#_Steps0200StarPathForBat()
	_Steps0300UnstructedAICode()
	_Steps0400PlayTheGame()
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
	bubble_set_footer("[center]Unstructured AI Tutorial · Made by [url=https://ko-fi.com/gamedevone][b]GameDevone[/b][/url] · [url=https://forms.gle/hyDPJDu6Qcnxubc59][b][?]Submit Feedback[/b][/url][/center]")
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
	bubble_set_avatar_at(Bubble.AvatarAt.RIGHT)
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
		"Through a combination of the AI and Path nodes, we will design the Unstructured AI for the bat to use.",
		])
	queue_command(func show_nodes():
		for node in EditorInterface.get_edited_scene_root().get_children():
			if node.has_method("show"):
				node.show()
		)
	complete_step()
	
	# 0150: Introducing the Unstructured AI
	bubble_set_title("UNSTRUCTURED AI?")
	bubble_add_text([
	"Well, Unstructered AI is the best approach to implementing AI initially.",
	"This involves writing code to address specific behaviors, such as repeating an attack pattern or following a specific path.",
	"Its effectiveness is best seen with one or two simultaneous behaviors but becomes challenging when dealing with more than just a few.",
	"So lets get into it!"
	])
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
	highlight_scene_nodes_by_path(["Bat/AI"])
	bubble_move_and_anchor(interface.canvas_item_editor, Bubble.At.TOP_LEFT)
	bubble_set_avatar_at(Bubble.AvatarAt.CENTER)
	bubble_set_title("OPEN THE AI SCRIPT")
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
	
	# 0320: AI Code Initialize Variables
	highlight_code(54,58)
	bubble_move_and_anchor(interface.inspector_dock, Bubble.At.BOTTOM_RIGHT)
	bubble_set_avatar_at(Bubble.AvatarAt.LEFT)
	bubble_set_title("AI Code Initialize Variables")
	bubble_add_text([
		"The AI Node should set its variables after all other Nodes in the Scene have had their turn.",
		"This ensures that the Bat Scene's Nodes have been initialized properly before accessing any methods or variables.",
	])
	bubble_add_code([
		"await owner.ready",
		])
	bubble_add_task(
		"Copy and Paste Code above to Line 58.",
		1,
		func check_line_in_script(task: Task) -> int:
			var line_number = 58
			var line = EditorInterface.get_script_editor().get_current_script().source_code.get_slice("\n", line_number - 1)
			return 1 if line.contains("await owner.ready") else 0
	)
	complete_step()
	
	# 0321: AI Code Initialize Variables
	highlight_code(60,61)
	bubble_add_text([
		"Now we can set our variables for the AI starting with the [code]_Bat[/code] variable.",
	])
	bubble_add_code([
		"_Bat = owner",
		])
	bubble_add_task(
		"Copy and Paste Code above to Line 61.",
		1,
		func check_line_in_script(task: Task) -> int:
			var line_number = 61
			var line = EditorInterface.get_script_editor().get_current_script().source_code.get_slice("\n", line_number - 1)
			return 1 if line.contains("_Bat = owner") else 0
	)
	complete_step()
	
	# 0322: AI Code Initialize Variables
	highlight_code(63,69)
	bubble_add_text([
		"Let's check if the the _Bat has a valid PATH_MODE set before we set the _Path variable.",
		"The Bat.PATH_MODE is a group of string literals we'll use to determine which path Bat should use at the start of the game.",
		"More on that later in the tutorial.",
		"We want _Path to be set to the baked_points from the Curve3D resource in the Path3D Node.",
		"For this we'll use a combination of the PATH_MODE and 'Path' to get the correct Path3D Node from the Bat Scene.",
		"Then access the baked_points from that Path3D's curve variable.",
	])
	bubble_add_code([
	"if not _Bat.PATH_MODE == \"None\":
		# Baked points in local coordinates
		_Path = _Bat.get_node(_Bat.PATH_MODE + \"Path\").curve.get_baked_points()",
	])
	bubble_add_task(
		"Copy and Paste Code above to Line 67.",
		1,
		func check_lines_in_script(task: Task) -> int:
			var start_line: int = 67
			var end_line: int = 69
			var lines: Array[String] = []
			var code: String = "if not _Bat.PATH_MODE == \"None\":
		# Baked points in local coordinates
		_Path = _Bat.get_node(_Bat.PATH_MODE + \"Path\").curve.get_baked_points()"
			for line_number in range(start_line, end_line):
				lines.append(EditorInterface.get_script_editor().get_current_script().source_code.get_slice("\n", line_number - 1))
			for line_number in range(end_line - start_line):
				if not lines[line_number].contains(code.get_slice("\n", line_number)):
					return 0
			return 1
	)
	complete_step()
	
	# 0323: AI Code Initialize Variables
	highlight_code(71,73)
	bubble_add_text([
		"All points generated by the Path3D via baked_points come in coordinates local to the Bat Scene and not the Game Scene.",
		"So we will also convert them to the global world space as well."
	])
	bubble_add_code([
	"for i in _Path.size():
			_Path[i] = _Bat.to_global(_Path[i])",
	])
	bubble_add_task(
		"Copy and Paste Code above to Line 72.",
		1,
		func check_lines_in_script(task: Task) -> int:
			var start_line: int = 72
			var end_line: int = 73
			var lines: Array[String] = []
			var code: String = "for i in _Path.size():
									_Path[i] = _Bat.to_global(_Path[i])"
			for line_number in range(start_line, end_line):
				lines.append(EditorInterface.get_script_editor().get_current_script().source_code.get_slice("\n", line_number - 1))
			for line_number in range(end_line - start_line):
				if not lines[line_number].contains(code.get_slice("\n", line_number)):
					return 0
			return 1
	)
	complete_step()
	
	# 0324: AI Code Movement
	highlight_code(38,41)
	bubble_add_text([
		"To keep the bat's movement in-sync with the FPS, the logic will be located in the _physics_process function.",
		"We'll again check the PATH_MODE used to exit early if no mode has been set."
	])
	bubble_add_code([
		"if _Bat.PATH_MODE == \"None\":
		return"
	])
	bubble_add_task(
		"Copy and Paste Code above to Line 40.",
		1,
		func check_lines_in_script(task: Task) -> int:
			var start_line: int = 40
			var end_line: int = 41
			var lines: Array[String] = []
			var code: String = "if _Bat.PATH_MODE == \"None\":
		return"
			for line_number in range(start_line, end_line):
				lines.append(EditorInterface.get_script_editor().get_current_script().source_code.get_slice("\n", line_number - 1))
			for line_number in range(end_line - start_line):
				if not lines[line_number].contains(code.get_slice("\n", line_number)):
					return 0
			return 1
	)
	complete_step()
	
	# 0325: AI Code Movement
	highlight_code(43,45)
	bubble_add_text([
		"Next we'll set the next path point if the bat is close to current point its moving towards.",
		"To do this we'll get the position of the Bat and compare its disance to the point it is trying to move towards with a minimum buffer distance of 0.25.",
		"So we can say it got close enough before moving to the next target position.",
		"The next target position will be calculated be incrementing the _TargetPathIndex variable and using the modulo operator (%) make loop back to the first point in the _Path."
	])
	bubble_add_code([
		"if _Bat.position.distance_to(_Path[_TargetPathIndex]) < 0.25:
		_TargetPathIndex = (_TargetPathIndex + 1) % _Path.size()"
	])
	bubble_add_task(
		"Copy and Paste Code above to Line 44.",
		1,
		func check_lines_in_script(task: Task) -> int:
			var start_line: int = 44
			var end_line: int = 45
			var lines: Array[String] = []
			var code: String = "if _Bat.position.distance_to(_Path[_TargetPathIndex]) < 0.25:
		_TargetPathIndex = (_TargetPathIndex + 1) % _Path.size()"
			for line_number in range(start_line, end_line):
				lines.append(EditorInterface.get_script_editor().get_current_script().source_code.get_slice("\n", line_number - 1))
			for line_number in range(end_line - start_line):
				if not lines[line_number].contains(code.get_slice("\n", line_number)):
					return 0
			return 1
	)
	complete_step()
	
	# 0326: AI Code Movement
	highlight_code(47,49)
	bubble_add_text([
		"Recalculating direction and velocity to the current point will allow us to set how we want the Bat to move.",
		"First by getting the direction to the target point then multiplying that by the Bat's speed to determine its velocity."
	])
	bubble_add_code([
		"var _Direction: Vector3 = _Bat.position.direction_to(_Path[_TargetPathIndex])
	_Bat.velocity = _Direction * _Bat.MovementSpeed"
	])
	bubble_add_task(
		"Copy and Paste Code above to Line 48.",
		1,
		func check_lines_in_script(task: Task) -> int:
			var start_line: int = 48
			var end_line: int = 49
			var lines: Array[String] = []
			var code: String = "var _Direction: Vector3 = _Bat.position.direction_to(_Path[_TargetPathIndex])
	_Bat.velocity = _Direction * _Bat.MovementSpeed"
			for line_number in range(start_line, end_line):
				lines.append(EditorInterface.get_script_editor().get_current_script().source_code.get_slice("\n", line_number - 1))
			for line_number in range(end_line - start_line):
				if not lines[line_number].contains(code.get_slice("\n", line_number)):
					return 0
			return 1
	)
	complete_step()
	
	# 0327: AI Code Movement
	highlight_code(51,52)
	bubble_add_text([
		"Uisng the move_slide() from the CharacterBody3D Node we can offically move the Bat based on the velocity previously set."
	])
	bubble_add_code([
		"_Bat.move_and_slide()"
	])
	bubble_add_task(
		"Copy and Paste Code above to Line 52.",
		1,
		func check_line_in_script(task: Task) -> int:
			var line_number = 52
			var line = EditorInterface.get_script_editor().get_current_script().source_code.get_slice("\n", line_number - 1)
			return 1 if line.contains("_Bat.move_and_slide()") else 0
	)
	complete_step()
	
	# 0330: AI Code Completion
	bubble_move_and_anchor(interface.script_editor, Bubble.At.CENTER)
	bubble_set_title("AI Script Completed!")
	bubble_add_text([
		"Great job! You've successfuly coded the Unstructured AI for the Bat.",
		"The last remaining steps for us will be to select which path the Bat will use in the Game Scene."
	])
	complete_step()
	pass


func _Steps0400PlayTheGame() -> void:
	# 0400
	context_set_3d()
	highlight_scene_nodes_by_path(["Bat"])
	bubble_move_and_anchor(interface.canvas_item_editor, Bubble.At.TOP_LEFT)
	bubble_set_avatar_at(Bubble.AvatarAt.CENTER)
	bubble_set_title("Additional Remarks")
	bubble_add_text([
		"So far weve avoided talking about the Script attached to the Bat itself.",
		"You may have noticed that the code we just wrote could have been written in the Bat Node script.", 
		"Instead, we've employed a common practiced used in the game industry called [b]Seperation of Concerns (SoC)[/b].",
		"See [url=https://wikipedia.org/wiki/Separation_of_concerns#:~:text=In%20computer%20science%2C%20separation%20of,code%20of%20a%20computer%20program]'Deisgn Principle - Separation of Concerns'[/url] for more info."
		
	])
	complete_step()
	
	# 0401
	bubble_add_text([
		"This practice is important for our Unstructed AI because we can eliminate a limition that comes with it.", 
		"That limitation being the lack of ability to re-use the AI for another creature or scene.",
		"By seperating concerns we eliminate the fact that the AI can only be used for the Bat and here is how we can effectively imagine this practice going forward.",
	])
	complete_step()
	
	# 0402
	highlight_scene_nodes_by_path(["Bat", "Bat/AI"])
	bubble_add_text([
		"The [b]Bat Node[/b] is concerned about controlling access to its nodes for objects [b]OUTSIDE[/b] of the Bat Scene.",
		"While the [b]AI Node[/b] will be concerned about any interactions between the nodes [b]INSIDE[/b] the Bat scene.",
		"So when we want to re-use the Unstructured AI later, we'll only need to copy the AI scene as a child Node to a new enemy.",
		
	])
	bubble_add_texture(BATWORLDVIEWPNG)
	complete_step()
	
	# 0403
	bubble_move_and_anchor(interface.spatial_editor, Bubble.At.CENTER)
	bubble_add_text([
		"But enough about the AI node, let's get back to the task at hand.",
		"To see our StarPath in action we need to move over to the Bats in the Game.tscn"
	])
	complete_step()
	
	# 0410
	context_set_3d()
	scene_open(ProjectSettings.get_setting("application/run/main_scene"))
	scene_select_nodes_by_path([
		"Game/Enemies/Bat0"
		])
	highlight_scene_nodes_by_path([
		"Game/Enemies/Bat0",
		])
	highlight_controls([interface.inspector_dock])
	bubble_move_and_anchor(interface.canvas_item_editor, Bubble.At.BOTTOM_LEFT)
	bubble_set_title("Bat Path Mode")
	bubble_add_text([
		"The Path Mode for the Bat can be set from the Game Scene by selecting the Path Mode in the Inspector Dock.",
	])
	bubble_add_task(
		"Select the [code]Star[/code] Path Mode",
		1,
		func select_star_path_mode(task: Task) -> int:
			var selected_node = EditorInterface.get_selection().get_selected_nodes()[0]
			return 1 if selected_node.get("PATH_MODE") == "Star" else 0
	)

	mouse_move_by_callable(
		get_tree_item_center_by_path.bind(interface.scene_tree, ("Game/Enemies/Bat0")),
		find_editor_inspector_property_button_center.bind("PATH_MODE")
	)
	mouse_click()
	complete_step()
	
	# 0420
	highlight_controls([interface.run_bar_play_button], true)
	bubble_set_avatar_at(Bubble.AvatarAt.LEFT)
	bubble_move_and_anchor(interface.spatial_editor, Bubble.At.TOP_RIGHT)
	bubble_add_text([
		"Now we can play the game and see the new Bat AI in action.",
	])
	bubble_add_task_press_button(interface.run_bar_play_button)
	complete_step()
	
	# 0430
	bubble_move_and_anchor(interface.base_control, Bubble.At.CENTER)
	bubble_set_avatar_at(Bubble.AvatarAt.CENTER)
	bubble_set_title("ITS ALL COMING TOGETHER!")
	bubble_add_text([
		"You did it!",
		"We now have a Bat that is following the StarPath we created.",
		"By doing so, you've successfuly created your own Unstructured AI system.",
		"And now there is a Bat that we can easily modifiy to have several more interesting behaviors."
		])
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

# Returns all instances of the button with property name
func find_editor_inspector_property_button(name: String) -> Array:
	var b = []
	for child in interface.inspector_editor.find_children("", "EditorProperty", true, false):
		if child.label == name.capitalize():
			b = child.find_children("", "Button", true, false)
	if b.is_empty():
		print("Could not find Editor Propery: " + name)
	return b

# Returns the global position of a property in the Editor Inspector
func find_editor_inspector_property_button_center(name: String) -> Vector2:
	var Results: Vector2 = Vector2.ZERO
	var Btn = find_editor_inspector_property_button(name)
	
	if Btn.is_empty():
		return Results
	
	Btn = Btn[0]
	var Rect: Rect2 = Btn.get_global_transform() * Btn.get_rect()
	Results = Rect.get_center()
	
	return Results


func get_all_children(node: Node, level: int = 0):
	var _level: int = level # retains local level property
	for N in node.get_children():
		print(".".repeat(_level) + N.name + " | " + N.get_class())
		if N is EditorProperty:
			print(".".repeat(_level) + "[" + N.label + "]")
		if N.get_child_count() > 0:
			get_all_children(N, _level + 1)
#endregion
