@ECHO OFF
"D:\learning\AVRStudio\AvrAssembler2\avrasm2.exe" -S "D:\learning\AVRprogs\testUSART\labels.tmp" -fI -W+ie -o "D:\learning\AVRprogs\testUSART\testUSART.hex" -d "D:\learning\AVRprogs\testUSART\testUSART.obj" -e "D:\learning\AVRprogs\testUSART\testUSART.eep" -m "D:\learning\AVRprogs\testUSART\testUSART.map" "D:\learning\AVRprogs\testUSART\testUSART.asm"
