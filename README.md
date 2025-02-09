# GET - Godot Easy Transitions 🎬🚀
**GET (Godot Easy Transitions)** is a lightweight and flexible addon for the Godot Engine that provides smooth scene transitions using shaders and tweens.
It offers multiple transition effects that enhance the visual flow of your game.


## 🌟 Features
* 🎭 **Multiple Transition Effects:**
  * Diamond Pixel: Pixelated diamond-shaped transition.
  * Circle: Expanding or shrinking circular wipe.
  * Vertical & Horizontal Slices: Smooth slicing effects.
  * Fade: Simple fade-in and fade-out effect.

* 🎚️ **Customizable Tweens:**
  * Fully adjustable transition type, easing, duration, and reverse effects via TransitionTweenSettings.

* 🛠️ **Resource-Based System:**
  * Easily manage transitions using TransitionSettings.
  * Adjust textures, hold times, and pixel sizes for pixelated effects.

* 📡 **Global Signals:**
  * Receive updates for intro_started, intro_ended, outro_started, outro_ended, and scene_changed.

* ♿ **Accessibility Options:**
  * Skip transitions for players who prefer instant scene changes.
  * Modify the speed scale of transitions.


## 📥 Installation
1. Download or Clone the repository.
2. Place the `addons/` folder inside your Godot project.
3. Enable the plugin in `Project > Project Settings > Plugins`.


## ⚙️ Configuration
1. Go to `Project > Project Settings > Godot Easy > Transition`.
2. Customize the addon's behaviour as you like.
3. You're all set! ✅🎉


## 🚀 Getting Started

### 🎬 Changing Scenes with Transitions
To change scenes with smooth transitions, use one of the following functions:

* **Using a File Path:**
```
# Change scene using a file path
TransitionManager.change_scene_to_file("res://scenes/Level2.tscn")
```

* **Using a PackedScene:**
```
# Change scene using a PackedScene
var scene: PackedScene = preload("res://scenes/Level2.tscn")
TransitionManager.change_scene_to_packed(scene)
```

**Both functions will:**
* Apply your TransitionSettings.
* Play the intro transition.
* Hold for the configured duration (if applicable).
* Switch to the new scene.
* Play the outro transition.

## 🎨 Customizing Transition Effects
* ![icon](https://github.com/user-attachments/assets/bbe612db-2a94-4389-bea3-65d280ea303d) **TransitionSettings**: Defines global transition settings, including texture, hold time, and pixel size.
* ![icon](https://github.com/user-attachments/assets/e225bd39-b719-4c28-b3e9-4bae7733dd3e) **TransitionTweenSettings**: Controls animation properties such as easing, transition type, and duration.

These resources can be created in the Godot editor and assigned to transitions dynamically.

## 🛠️ Debugging & Accessibility
The addon features a built-in debug log setting that can be easily turned on and off.
It also provides multiple accessibility options.

## 📖 Documentation
For more details, refer to the **Wiki** which covers:
* Installation
* Configuration
* Usage
* Advanced Usage
* Resources
* Best Practices & Limitations

## 🤝 Contributing
Contributions are welcome! Check the Contributing Guidelines for details on how to report issues, suggest improvements, and submit pull requests.

## 📜 License
**GET - Godot Easy Transitions** is licensed under the MIT License.

---
Enhance your game's scene transitions with GET and make them smooth and cinematic! 🎬✨
