\export ar_check=no
bash ./autogen.sh
./configure --with-sdlsound --without-png  --with-sdlsound --without-resid --enable-sdlui --disable-realdevice --disable-rs232  --without-png --target=wasm32-unknown-emscripten 
make
