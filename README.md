# OBS Scene Toggle / Hold Script

A lightweight Lua script for OBS Studio that lets you swap between two scenes using a single hotkey.

Supports:

- Toggle mode (press once to swap)
- Hold mode (switch while key is held)
- Fully configurable scene selection
- Native OBS hotkey integration

---

## 🎬 Features

### Toggle Mode
Press the assigned hotkey once:
- Scene A → Scene B
- Scene B → Scene A

### Hold Mode
- Hold key → switch to Scene B
- Release key → return to Scene A

Perfect for:
- Gameplay ↔ Facecam switching
- Dev screen ↔ Fullscreen preview
- Instant zoom scenes
- Stream overlays

---

## 📥 Installation

1. Download `scene_toggle_hold.lua`
2. Open OBS Studio
3. Go to:
   Tools → Scripts
4. Click `+` and add the Lua file
5. Select:
   - Scene A
   - Scene B
   - Mode (Toggle or Hold)

Then:

Settings → Hotkeys  
Bind **Scene Swap (Toggle / Hold)** to your desired key (e.g., G).

---

## ⚙ Requirements

- OBS Studio 28+  
- No Python required  
- Works on Windows / Linux / macOS  

---

## 🧠 How It Works

The script registers a frontend hotkey using the OBS Lua API and:

- Detects the current scene
- Switches based on selected mode
- Uses native OBS scene switching functions

No external dependencies.

---

## 🔧 Customization Ideas

You can extend this script to:

- Use a specific transition type
- Add debounce protection
- Only activate while streaming
- Detect specific source visibility
- Add multi-scene cycling
- Add sound feedback on swap

---

## 📜 License

MIT License — free to modify and distribute.

---

## 💬 Contributing

Pull requests and improvements are welcome.
