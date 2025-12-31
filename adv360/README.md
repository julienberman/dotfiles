### Kinesis Advantage 360

Steps for configuring the keyboard layouts for the Kinesis Advantage 360. The keyboard uses the SmartSet firmware (not ZMK or QMK). There are 9 layouts ("profiles") that can be edited.

### Configuring
1) Plug in keyboard and activate the "v-drive" with
```SmartSet + HotKey3```

2) Mount the keyboard. On MacOS this is likely automatic. On hyprland, first identify the device with
```lsblk```

Then, mount it to `/mnt/adv360` with
```sudo mount /dev/<BLOCKNAME> /mnt/adv360```

3) Edit text files in `layouts` or in `lighting`. Do not touch `settings.txt`.

4) Unmount the keyboad. On MacOS, this likely requires "ejecting" the drive. On hyprland, run:
```
sync
sudo umount /mnt/adv360
```

5) Deactivate the "v-drive" with 
```SmartSet + HotKey3```

### Switching Layouts
For a temporary change, press:
```SmartSet + <LAYOUT_NUM>```

For a permanent layout change, press:
```SmartSet + shift + <LAYOUT_NUM>```




