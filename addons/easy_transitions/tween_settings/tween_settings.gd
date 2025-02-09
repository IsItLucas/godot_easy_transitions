@tool
@icon("res://addons/easy_transitions/tween_settings/icon.png")
class_name TransitionTweenSettings extends Resource


## TransitionTweenSettings stores tweening properties for transition effects.
##
## The TransitionTweenSettings allows  consistent transition effects across
## different transition effects.
## It can store the same information a Tween can.


## Specifies the transition type (e.g., linear, cubic, elastic).
@export var transition := Tween.TransitionType.TRANS_SINE

## Defines the easing function (e.g., in, out, in-out).
@export var ease := Tween.EaseType.EASE_IN_OUT

## The transition type (e.g., fade, circle, etc.).
@export var type := TransitionTypes.FADE

## Duration of the tween in seconds.
@export var duration := 1.0

## Reverse effect.
@export var reverse := false


## Enum defining the available transition types.
enum TransitionTypes {
	## Diamond transition type.
	DIAMOND,
	
	## Cartoony circle transition type.
	CIRCLE,
	
	## Smooth vertical slice transition type.
	VERTICAL_SLICE,
	
	## Smooth horizontal slice transition type.
	HORIZONTAL_SLICE,
	
	## Simple fade transition type..
	FADE,
}


## Sets a new transition type and returns the updated resource.
func set_transition(new_transition: Tween.TransitionType) -> TransitionTweenSettings:
	transition = new_transition
	return self


## Sets a new easing type and returns the updated resource.
func set_ease(new_ease: Tween.EaseType) -> TransitionTweenSettings:
	ease = new_ease
	return self

## Sets a new duration for the tween and returns the updated resource.
func set_duration(new_duration: float) -> TransitionTweenSettings:
	duration = new_duration
	return self


## Sets whether the effect is reversed or not and returns the updated resource.
func set_reverse(reversed: bool) -> TransitionTweenSettings:
	reverse = reversed
	return self


## Sets the transition type and returns the updated resource.
func set_type(new_type: TransitionTypes) -> TransitionTweenSettings:
	type = new_type
	return self


## Returns the current transition type.
func get_transition() -> Tween.TransitionType:
	return transition


## Returns the current easing type.
func get_ease() -> Tween.EaseType:
	return ease


## Returns the adjusted tween duration in seconds.
func get_duration() -> float:
	var speed_scale: float = TransitionHelper.get_setting("accessibility/speed_scale", 1.0)
	return duration * speed_scale


## Returns if the effect is reversed or not.
func is_reversed() -> bool:
	return reverse


## Returns the transition type.
func get_type() -> TransitionTypes:
	return type
