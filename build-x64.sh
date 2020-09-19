echo compiling js...
cp src/x64sc src/x64.o
emcc src/x64.o  -O2 -o ../js/x64.js -s DOUBLE_MODE=0 \
     -s WARN_ON_UNDEFINED_SYMBOLS=1 -s TOTAL_MEMORY=33554432 -s ALLOW_MEMORY_GROWTH=1 -s USE_SDL=1 -s WASM=1 -s SINGLE_FILE=1 \
    -s EXPORTED_FUNCTIONS="[ \
        '_autostart_autodetect', \
        '_cmdline_options_string', \
        '_file_system_attach_disk', \
        '_file_system_detach_disk', \
        '_file_system_get_disk_name', \
        '_joystick_set_value_and', \
        '_joystick_set_value_or', \
        '_keyboard_key_pressed', \
        '_keyboard_key_released', \
        '_machine_trigger_reset', \
        '_main', \
        '_set_playback_enabled' \
    ]" \
    --embed-file "data/C64@/C64" --embed-file "data/DRIVES@/DRIVES" --embed-file "data/fonts@/fonts"
