### USB Relay Shutter Release Script

## Description:

This script is intended to be used with older DSLR cameras that don't have the ability to control the shutter over USB.  A modified shutter release cable connected to a USB relay is required for this to run.  The camera must also be in BULB mode.

## Run example:

.\serial_relay_shutter_control.ps1 -com_port_number 8 -baud_rate 9600 -exposure_time_seconds 120 -number_of_pictures 10

The above example will connect to COM7 at baud 9600 taking a 2 minute exposure waiting 1 second between exposures.  It will take a total of 10 pictures like this.
