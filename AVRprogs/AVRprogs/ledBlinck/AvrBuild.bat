@ECHO OFF
"D:\learning\AVRStudio\AvrAssembler2\avrasm2.exe" -S "D:\learning\AVRprogs\ledBlinck\labels.tmp" -fI -W+ie -o "D:\learning\AVRprogs\ledBlinck\ledBlinck.hex" -d "D:\learning\AVRprogs\ledBlinck\ledBlinck.obj" -e "D:\learning\AVRprogs\ledBlinck\ledBlinck.eep" -m "D:\learning\AVRprogs\ledBlinck\ledBlinck.map" "D:\learning\AVRprogs\ledBlinck\ledBlinck.asm"
