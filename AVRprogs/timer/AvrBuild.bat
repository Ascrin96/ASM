@ECHO OFF
"D:\learning\AVRStudio\AvrAssembler2\avrasm2.exe" -S "D:\learning\AVRprogs\timer\labels.tmp" -fI -W+ie -o "D:\learning\AVRprogs\timer\timer.hex" -d "D:\learning\AVRprogs\timer\timer.obj" -e "D:\learning\AVRprogs\timer\timer.eep" -m "D:\learning\AVRprogs\timer\timer.map" "D:\learning\AVRprogs\timer\timer.asm"
