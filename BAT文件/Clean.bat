@echo off
echo list disk > wipe.txt
echo select disk 1 >> wipe.txt
echo clean all >> wipe.txt
diskpart /s wipe.txt
del wipe.txt