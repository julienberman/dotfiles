### Yabai config

Tiling window manager for macos. Install yabai as follows.
- macos:
```
brew install asmvik/formulae/yabai
```

Start program as follows.
```
brew services start yabai
```
On first launch, yabai  will request access to the accessibility API.

Note: the following Yabai services require System Integrity Protection to be (partially) disabled:
- focus/move/swap/create/destroy space
- remove window shadows
- enable window transparency
- enable window animations
- scratchpad windows
- control window layers (make windows appear topmost or on the desktop)
- sticky windows (make windows appear on all spaces on the display that contains the window)
- toggle picture-in-picture for any given window

To disable, consult [these docs](https://github.com/asmvik/yabai/wiki/Disabling-System-Integrity-Protection).
