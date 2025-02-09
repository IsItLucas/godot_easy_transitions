class_name TransitionHelper extends Node


## This class only serves as a helper class.
## It contains some utils and / or quality of life features.
## This is mainly used by GET - Godot Easy Transitions, but feel free to use it if you want / need.


## Prefix for all Godot Easy Input Remap settings in Project Settings.
const SETTINGS_NAME := "transition"


## Updates a specific [param setting] with a new [param value].
static func set_setting(setting: String, value: Variant) -> void:
	var path := get_setting_path(setting)
	if not ProjectSettings.has_setting(path):
		push_error("Failed to update setting \"%s\": the setting does not exist in the Project Settings. Verify the configuration in Project > Project Settings > General > Godot Easy > Transition." % setting)
	
	ProjectSettings.set_setting(path, value)


## Retrieves the value of a [param setting] or returns a [param default] value.
static func get_setting(setting: String, default: Variant = null) -> Variant:
	var path := get_setting_path(setting)
	return ProjectSettings.get_setting(path, default)


## Generates the full path for a given [param setting].
static func get_setting_path(setting: String) -> String:
	return "godot_easy/" + SETTINGS_NAME + "/" + setting
