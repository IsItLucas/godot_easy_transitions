extends CanvasLayer


## The transition manager, handling smooth scene transitions using shaders.


## Emitted when the intro animation starts.
signal intro_started

## Emitted when the outro animation starts.
signal outro_started

## Emitted when the intro animation ends.
signal intro_ended

## Emitted when the outro animation ends.
signal outro_ended

## Emitted when the scene changes (between [signal intro_started] and [signal outro_started]).
signal scene_changed


## The UI element where the transition shader is applied.
@onready var TransitionRect: TextureRect = %TransitionRect


## Stores the settings for the current transition.
var transition_settings: TransitionSettings = null


func _ready() -> void:
	# Set the default layer for the transition effect.
	var default_layer: int = TransitionHelper.get_setting("default/layer", 2)
	layer = default_layer


## Starts the intro transition (fade-in or other effect).
## This function shouldn't be called directly. Use [method change_scene_to_file] or [method change_scene_to_packed] instead.
func intro() -> void:
	# Emit a signal.
	intro_started.emit()
	
	# Get the tween settings that will be used in the intro.
	var tween_settings: TransitionTweenSettings = transition_settings.intro_tween
	
	# Update texture.
	TransitionRect.texture = transition_settings.texture
	
	# Apply transition-specific shader parameters.
	set_shader_parameter(&"pixel_size", transition_settings.pixel_size)
	set_shader_parameter(&"reversed", tween_settings.reverse)
	set_shader_parameter(&"type", tween_settings.type)
	set_shader_parameter(&"progress", 0.0)
	
	# Set the shader's screen size parameter dynamically based on the viewport size.
	var screen_size: Vector2i = get_viewport().size
	set_shader_parameter(&"screen_size", screen_size)
	
	# Create and configure a tween animation for the transition effect.
	var material: ShaderMaterial = TransitionRect.material
	var tween: Tween = get_tree().create_tween().set_ease(tween_settings.ease).set_trans(tween_settings.transition).set_ignore_time_scale(true)
	tween.tween_property(material, ^"shader_parameter/progress", 1.0, tween_settings.duration / Engine.time_scale)
	
	# Debug log message.
	var debug_log: bool = TransitionHelper.get_setting("debug_log", true)
	if debug_log:
		print("Playing intro animation...")
	
	# Wait until the animation is finished.
	await tween.finished
	
	# Emit a signal.
	intro_ended.emit()


## Starts the outro transition (fade-out or other effect).
## This function shouldn't be called directly. Use [method change_scene_to_file] or [method change_scene_to_packed] instead.
func outro() -> void:
	# Emit a signal.
	outro_started.emit()
	
	# Get the tween settings that will be used in the intro.
	var tween_settings: TransitionTweenSettings = transition_settings.outro_tween
	
	# Apply transition-specific shader parameters.
	set_shader_parameter(&"reversed", tween_settings.reverse)
	set_shader_parameter(&"type", tween_settings.type)
	set_shader_parameter(&"progress", 1.0)
	
	# Create and configure a tween animation for the transition effect.
	var material: ShaderMaterial = TransitionRect.material
	var tween: Tween = get_tree().create_tween().set_ease(tween_settings.ease).set_trans(tween_settings.transition).set_ignore_time_scale(true)
	tween.tween_property(material, ^"shader_parameter/progress", 0.0, tween_settings.duration)
	
	# Debug log message.
	var debug_log: bool = TransitionHelper.get_setting("debug_log", true)
	if debug_log:
		print("Playing outro animation...")
	
	# Wait until the animation is finished.
	await tween.finished
	
	# Emit a signal.
	outro_ended.emit()


## Changes the scene using the file path [param scene_path] using the [class TransitionSettings] [param settings].
func change_scene_to_file(scene_path: String, settings: TransitionSettings = load(TransitionHelper.get_setting("default/settings_path"))) -> void:
	# Get debug log state.
	var debug_log: bool = TransitionHelper.get_setting("debug_log", true)
	
	# Check if transitions should be skipped:
	var skip: bool = TransitionHelper.get_setting("accessibility/skip", false)
	if skip:
		# Change scene.
		get_tree().change_scene_to_file(scene_path)
		
		if debug_log:
			print("Skipping transition and changing scene to " + scene_path)
		
		return
	
	# Update transition settings.
	transition_settings = settings
	if not transition_settings:
		push_error("Could not load the TransitionSettings.")
		return
	
	# Play intro transition before switching scenes.
	await intro()
	
	# Wait the hold time before proceeding.
	if transition_settings.hold > 0.0:
		if debug_log:
			print("Holding transition for %s seconds." % transition_settings.hold)
		
		await get_tree().create_timer(transition_settings.hold, true, false, true).timeout
	
	# Debug log message.
	if debug_log:
		print("Changing scene to " + scene_path)
	
	# Change scenes.
	get_tree().change_scene_to_file(scene_path)
	scene_changed.emit()
	
	# Play outro transition after switching.
	await outro()


## Changes the scene using the [class PackedScene] object [param scene] with a transition effect configured by the [class TransitionSettings] at [param settings_path].
func change_scene_to_packed(scene: PackedScene, settings: TransitionSettings = load(TransitionHelper.get_setting("default/settings_path"))) -> void:
	# Get debug log state.
	var debug_log: bool = TransitionHelper.get_setting("debug_log", true)
	
	# Check if transitions should be skipped:
	var skip: bool = TransitionHelper.get_setting("accessibility/skip", false)
	if skip:
		# Change scene.
		get_tree().change_scene_to_packed(scene)
		
		if debug_log:
			print("Skipping transition and changing scene to " + str(scene))
		
		return
	
	# Update transition settings.
	transition_settings = settings
	if not transition_settings:
		push_error("Could not load the TransitionSettings.")
		return
	
	# Play intro transition before switching scenes.
	await intro()
	
	# Wait the hold time before proceeding.
	if transition_settings.hold > 0.0:
		if debug_log:
			print("Holding transition for %s seconds." % transition_settings.hold)
		
		await get_tree().create_timer(transition_settings.hold, true, false, true).timeout
	
	# Debug log message.
	if debug_log:
		print("Changing scene to " + str(scene))
	
	# Change scenes.
	get_tree().change_scene_to_packed(scene)
	scene_changed.emit()
	
	# Play outro transition after switching.
	await outro()


## Sets a parameter value for the shader applied to the transition rect.
## This function shouldn't be called directly.
func set_shader_parameter(parameter: StringName, value: Variant) -> void:
	# Get the transition rect material.
	var material: ShaderMaterial = TransitionRect.material
	
	# Change parameters.
	material.set_shader_parameter(parameter, value)
