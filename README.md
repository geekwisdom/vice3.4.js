# vice3.4.js
Emscripten port of the emulator VICE, version 3.4.

My goal is to have a working VICE VIC20 emualtor so that i can
share my vic20 disk images (.d64 format)
## Credit

* This code is based on the repo @ https://github.com/Sgeo/vice32

* Inspired by the repo at https://github.com/rjanicek/vice.js/

## Build instructions
Install emscripten (this one was done with emc 2.0.4)

Ensure you have the clang, gcc, g++ build tools, libsdl2-dev

The part_build.sh attempts to configure and build the .o files as
WebAssembly (wasm) binary module version 0x1

It will likely crash the first time complaining about the @DYNLIBS@ in the
main Makefile. You can delete this manually and rebuild

It will bomb as second time trying to build the x128, but will build x64dtv and x64sc 
successfully.

You can then run the ./build-x64.html to build the x64sc files. It will create an 
x64sc.html x64sc.js and x64sc.swasm

You can then run the ./build-x64dv.html to build the x64sc files. It will create an 
x64dtv.html x64dtv.js and x64dtv.wasm

You can then run the ./build-xvic.html to build the x64sc files. It will create an 
xvic.html xvic.js and x64vic.wasm

IMPORTANT: Don't run the html files directly, instead use the supplied testxvic,
testx64sc and testx64dtv.html files. Why? - Because the sound cannot initiize and it will 'freeze'
the html files require you to click a button first, which allows the sound to initialize (this is a safety feature in browsers to prevent sounds
when user has not interacted with page)

x64dtv almost shows something :)

xvic and x64sh just show black screens at present :(
