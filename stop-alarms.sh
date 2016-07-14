#!/bin/bash

killall alarm-clock-applet;
alarm-clock-applet & disown

read "SDFG"
