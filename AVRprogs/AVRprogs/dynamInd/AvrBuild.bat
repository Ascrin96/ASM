@ECHO OFF
"D:\learning\AVRStudio\AvrAssembler2\avrasm2.exe" -S "D:\learning\AVRprogs\dynamInd\labels.tmp" -fI -W+ie -o "D:\learning\AVRprogs\dynamInd\dynamInd.hex" -d "D:\learning\AVRprogs\dynamInd\dynamInd.obj" -e "D:\learning\AVRprogs\dynamInd\dynamInd.eep" -m "D:\learning\AVRprogs\dynamInd\dynamInd.map" "D:\learning\AVRprogs\dynamInd\dynamInd.asm"
