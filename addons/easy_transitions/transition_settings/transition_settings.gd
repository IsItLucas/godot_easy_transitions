@tool
@icon("res://addons/easy_transitions/transition_settings/icon.png")
class_name TransitionSettings extends Resource


## Stores settings related to scene transitions.
##
## This resource can store information used in transitions like
## intro tweens, outro tweens, textures, etc.


## General transition settings.
@export_group("Settings")

## The texture used for the transition effect.
@export var texture: Texture2D = null

## Time (in seconds) to wait before starting the outro transition.
@export var hold := 1.0

## Pixel size for pixelated transitions.
@export var pixel_size := 16


## Tween settings for intro and outro animations.
@export_group("Tweening")

## Settings for the intro transition.
@export var intro_tween: TransitionTweenSettings

## Settings for the outro transition.
@export var outro_tween: TransitionTweenSettings


## Sets the transition texture and returns the updated resource.
func set_texture(new_texture: Texture2D) -> TransitionSettings:
	texture = new_texture
	return self


## Sets the hold time before outro transition and returns the updated resource.
func set_hold(new_hold: float) -> TransitionSettings:
	hold = new_hold
	return self


## Sets the pixel size for pixelated transitions and returns the updated resource.
func set_pixel_size(new_pixel_size: int) -> TransitionSettings:
	pixel_size = new_pixel_size
	return self


## Sets the intro tween settings and returns the updated resource.
func set_intro_tween(new_intro_tween: TransitionTweenSettings) -> TransitionSettings:
	intro_tween = new_intro_tween
	return self


## Sets the outro tween settings and returns the updated resource.
func set_outro_tween(new_outro_tween: TransitionTweenSettings) -> TransitionSettings:
	outro_tween = new_outro_tween
	return self


## Returns the transition texture.
func get_texture() -> Texture2D:
	return texture


## Returns the hold time.
func get_hold() -> float:
	return hold


## Returns the pixel size.
func get_pixel_size() -> int:
	return pixel_size


## Returns the intro tween settings.
func get_intro_tween() -> TransitionTweenSettings:
	return intro_tween


## Returns the outro tween settings.
func get_outro_tween() -> TransitionTweenSettings:
	return outro_tween
