[![Build Status](https://travis-ci.org/allred/piloto.svg?branch=master)](https://travis-ci.org/allred/piloto)
[![Code Climate](https://codeclimate.com/github/allred/piloto/badges/gpa.svg)](https://codeclimate.com/github/allred/piloto)

# piloto

This project is intended to run on at least two hosts:

* Receiver
* Reaper

Take a look at setup.txt for in-progress documentation.

## Receiver

The Receiver is just a host that listens to things like GPS and wifi.  It is mostly passive, except for establishing some kind of tunnel/conduit to the Reaper as it can.  The focus is to be rebootable, rugged, deal with local hardware idiosyncrasies, etc.

The initial intention is to run this part of the code on a Raspberry Pi 3+.  You can run it on a Raspberry Pi 2 if you have an additional wifi dongle.  It will be tested again on Raspberry Pi 1 at some point.  USB power and memory requirements come into play on the Raspberry Pi platform.

You will need at least two wifi devices, and importantly, one wifi device (a USB dongle is an easy choice) that can go into monitor mode.  The Raspberry Pi 3 has an onboard wifi device, which makes the Pi3 platform an optimal choice as of 2016.

USB wifi devices, some tested and sane choices:

* ALFA AWUS036NEH
* TP-LINK TL-WN722N

USB GPS receivers, some tested and recommended ones:

* U-blox7

Power requirements are in flux, but a modern 20k+ mAh usb battery pack is a good place to start.

## Reaper

The initial intention is to run this part of the code on an EC2 instance.  This is where data gathering and analysis will likely occur, or at least a gateway for such.  Receivers which connect will be polled for data.
