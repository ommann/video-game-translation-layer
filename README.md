# Video game translation layer
A tool for applying fan translations over video games using image search. This is an crude alternative to modding the game itself.

Proof of concept is done for FCEUX and VBA-rr emulators. Script is dependent on [lua-gd](https://github.com/ittner/lua-gd).

The script looks from inputted coordinates for images in a "input" folder. When match is found the coordinates are then used to draw image from "output" folder.
