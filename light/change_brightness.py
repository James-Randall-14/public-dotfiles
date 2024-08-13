#!/usr/bin/python3

import sys
import os
import time
import math

intervals = 15
base = 100.0 ** (1 / (intervals - 1))
interval_values = [round(base ** i, 1) for i in range(intervals)]
steps = 10

def get_bright_percent():
    return round(float(os.popen('light -G').read()), 1)

def get_requested_operation():
    if len(sys.argv) != 2:
        print("Incorrect number of arguments. Please pass either + or -")
        quit()

    if sys.argv[1] == '+':
        return 1
    elif sys.argv[1] == '-':
        return -1
    else:
        print("Unknown operation requested. Please pass either + or -")
        quit()

# Get the current interval of the screen's brightness (0.6% tolerance)
def get_brightness_interval():
    bright_percent = get_bright_percent()
    for i in range(len(interval_values)):
        if abs(interval_values[i] - bright_percent) == 0:
            return i
    return None

# Get the interval above the current brightness
def get_upper_interval():
    bright_percent = get_bright_percent()
    for i in range(len(interval_values)):
        if interval_values[i] > bright_percent:
            return i

# Get the interval below the current brightness
def get_lower_interval():
    bright_percent = get_bright_percent()
    for i in range(len(interval_values)):
        if interval_values[i] > bright_percent:
            return i - 1

# Wrapper function for setting brightness
def set_brightness(desired_brightness):
    os.system("light -S {}".format(desired_brightness))

# Change smoothly from one brightness value to another
def slide_brightness(desired_brightness):
    original_brightness = get_bright_percent()
    delta = desired_brightness - original_brightness
    interim_levels = [ original_brightness + i * delta / steps for i in range(steps + 1) ]
    for brightness in interim_levels:
        set_brightness(brightness)
        time.sleep(0.002)

def main():
    brightness_interval = get_brightness_interval()
    requested_operation = get_requested_operation()

    if brightness_interval is not None:
        desired_interval = max(min(brightness_interval + requested_operation, intervals - 1), 0)
        desired_brightness = interval_values[desired_interval]
        slide_brightness(desired_brightness)
    else:
        if requested_operation == 1:
            desired_interval = get_upper_interval()
            desired_brightness = interval_values[desired_interval]
            slide_brightness(desired_brightness)
        else:
            desired_interval = get_lower_interval()
            desired_brightness = interval_values[desired_interval]
            slide_brightness(desired_brightness)

if __name__ == "__main__":
    main()
    print(get_bright_percent())
