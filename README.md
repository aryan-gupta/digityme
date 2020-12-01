# digityme
A rpi clock project I am currently working on (yes, the name is purposefully misspelled)

The name is a wordplay on digital and time. 

### Description
A raspberry pi smart clock project based on this screen (click image for link)

[![Screen image](readme/screen_link.jpg?raw=true)](https://www.amazon.com/gp/product/B07VV7RL7Y/)

## How to use
 - Run the setup script with the SD card that you want to install to. 
   - Example: `./os/setup.sh /dev/disk/by-id/usb-Multiple_Card_Reader_058F63666438-0:0`
 - Print out the items in `3dprint/` folder
 - Assemble device
 - ???
 - Profit

## Map
 - `3dprint/` - 3D models for the stand and case
 - `os` - A setup script for the OS SD card and other init code
 - `webapp` - The app that runs the clock UI
 - `readme` - Dependency files for readme's

### Features
Tells the time
Time app is hosted in a docker container
More features coming soon

### Hardware
 - Raspberry Pi (for now, looking for something smaller)
 - The screen above
 - Solder/Iron (to solder the pins for the display)
 - 3D printer
