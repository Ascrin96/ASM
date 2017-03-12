@ECHO OFF
"D:\learning\AVRStudio\AvrAssembler2\avrasm2.exe" -S "D:\learning\AVRprogs\ACP\labels.tmp" -fI -W+ie -o "D:\learning\AVRprogs\ACP\ACP.hex" -d "D:\learning\AVRprogs\ACP\ACP.obj" -e "D:\learning\AVRprogs\ACP\ACP.eep" -m "D:\learning\AVRprogs\ACP\ACP.map" "D:\learning\AVRprogs\ACP\ACP.asm"
