# Hubstaff Tracker... tracker!

A simple bash script to see how often the time tracking app "Hubstaff" takes screenshots of your screen

## Demo

(put screenshot/video here)

## Requirements/Dependencies
- Dbus-monitor
- awk
- bc

## Installation

1. Download the script
2. Put it in your desired folder
3. Run!

(Don't forget to chmod +x if applicable)

## Usage

```
./hubstaff-tracker-tracker
```

Run the script **before** starting your timer

The output by default goes to the folder the script is located in.

## Configuration

Feel free to poke around inside the source file, it's a very small simple script.

The path to the output file can easily be edited to output elsewhere.

The bottom of the script can be changed to format to your liking.

## Notes

This script will only work on a Linux-based system that uses dbus

### TODO

- [ ] Track total time from timer start to timer stop
- [ ] Potentially create alternative for Windows
- [ ] Potentially create alternative for MacOS
