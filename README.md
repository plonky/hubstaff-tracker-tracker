# Hubstaff Tracker... tracker!

A simple bash script to see how often the time tracking app "Hubstaff" takes screenshots of your screen

## Why?

I wanted to see how often my particular organization takes screenshots, to look for correlations.

Using this script, I was able to discover that the screenshots are not actually completely "random",

but rather have a seeminly hard upper and average cap. To me, this is valuable information.

Know thy enemy

## Demo

(put screenshot/video here)

Example output:
```
----------
Sun Mar 22 04:19:47 AM [timezone] 2026
----------
Amount of screenshots taken: 124
Average time between screenshots: 4m 58s
Largest gap: 8m 21s
Smallest gap: 1m 14s

----------
Sun Mar 22 06:19:56 PM [timezone] 2026
----------
Amount of screenshots taken: 51
Average time between screenshots: 4m 57s
Largest gap: 8m 1s
Smallest gap: 2m 13s

----------
Mon Mar 23 02:00:52 AM [timezone] 2026
----------
Amount of screenshots taken: 44
Average time between screenshots: 5m 2s
Largest gap: 8m 32s
Smallest gap: 1m 56s

----------
Tue Mar 24 12:16:32 AM [timezone] 2026
----------
Amount of screenshots taken: 102
Average time between screenshots: 4m 59s
Largest gap: 8m 35s
Smallest gap: 1m 17s
```

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

- [ ] Add screenshot/video to README
- [ ] Track total time from timer start to timer stop
- [ ] Potentially create alternative for Windows
- [ ] Potentially create alternative for MacOS
