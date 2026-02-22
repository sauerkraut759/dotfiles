#!/bin/bash

monitor=$(hyprctl activeworkspace | grep -m 1 monitorID | xargs -I{} expr {} : ".*\([0-9]\)")

hyprctl dispatch workspace $(($monitor * 4 + $1))
