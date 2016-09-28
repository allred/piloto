### piloto

This project is intended to run on at least two hosts:

* Receiver
* Reaper (temporary name?)

# Reciever

The Receiver is just a host that listens to things like GPS and wifi.  It is mostly passive, except for establishing some kind of tunnel/conduit to the Reaper as it can.  The focus is to be rebootable, rugged, deal with local hardware idiosyncracies, etc.

Part of the code is intended to be run on a Raspberry Pi 3+.  You can run it on a Raspberry Pi 2 if you have an extra wifi dongle.  It will be tested again on Raspberry Pi 1 at some point.  USB power requirements and memory requirements come into play.

You will need at least two wifi devices, and importantly, one wifi device (a USB dongle is an easy choice) that can go into monitor mode.  The Raspberry Pi 3 has an onboard wifi device, which makes it an ideal choice as of 2016.

USB wifi devices, some tested and sane choices:

* TP-LINK TL-WN722N

You may also want a GPS receiver, some recommended ones:

* U-blox7
