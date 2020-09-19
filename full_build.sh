export ar_check=no
./configure --enable-sdlui --with-sdlsound --without-png --target=wasm32-unknown-emscripten
make
emconfigure ./configure --enable-sdlui --with-sdlsound --without-png --target=wasm32-unknown-emscripten 
emmake make
