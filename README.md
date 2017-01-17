# Video game translation layer
A tool for applying fan translations over video games using image search. This is an crude alternative to modding the game itself.

The script looks from given coordinates for a certain image and if the correct image is found then draws over it. This is useful for replacing text elements from one language into another .

Script works on FCEUX, VBA-rr and DeSmuME emulators. Script is dependent on [lua-gd](https://github.com/ittner/lua-gd).

# Example
![alt text](/example_pokemon.png "Scratch leads to victory!")

The japanese for "scratch" have been painted over with "scratch" taken from FireRed's international release. The pixels can be painted to be anything, in this case inverted colors were used.
