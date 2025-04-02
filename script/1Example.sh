#!/bin/bash

message="""
THIS IS NOT A SUBLIMINAL MESSAGE
⣿⣿⣿⣿⠟⣩⣴⣶⣦⣍⠻⣿
⣿⣿⣿⢏⣾⣿⣿⠿⣿⣿⣿⣌⢻
⣿⠟⣩⣬⣭⠻⣿⣀⣿⣿⣿⢟⣤⡙⢿
⣷⣤⣒⠲⠶⢿⣘⣛⣻⠿⣿⣸⣿⣿⣷⣝⠿
⣿⣿⣿⣿⠸⣿⣿⣿⣿⣿⣦⢹⣿⣿⣿⣿⣷⣌⠻⣿
⣿⡿⢉⣴⣶⣦⠙⣿⣿⣿⣿⡼⣿⣿⣿⣿⣿⢿⣷⡌⢿
⣿⣷⡘⠿⠟⣛⡁⢻⣿⣿⣿⣿⣝⢿⣿⠻⣿⢮⣭⣥⣄⡹⣿
⣿⣿⡇⢿⣿⣿⣿⠘⣿⣿⣿⣿⣿⣷⣦⣟⡶⠶⢾⣭⣽⣗⡈⠻⣿
⣿⣿⣷⡈⣿⣿⣿⣧⣌⠛⠿⣿⣿⣿⣿⣿⣿⣷⣷⡲⣶⣶⣾⣷⣌⡛⢿
⣿⣿⣿⠗⡈⠻⣿⣿⡿⢛⣶⣤⣍⠻⣿⣿⣿⣿⣿⡿⠆⠻⠿⣿⣿⡿⠗
⣿⣿⡏⢼⣿⣷⣶⢋⣴⣿⣿⣿⣿⡇⢀⣠⠄⣠⣶⣶⣿⣿⣷⣶⣶⣶⣿
⣿⣿⣷⣌⠛⠛⠛⠈⠛⠛⠛⠛⢛⠁⢈⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣇⡈⢉⣩⡭⠽⢛⣒⣒⣒⣈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣇⣉⣥⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
ESTO NO ES UN MENSAJE SUBLIMINAL
"""


clear

echo "$message"


for i in {1..20}; do
    clear
    sleep 0.1
    echo "$message"
    sleep 0.1
done


clear


cols=$(tput cols)
rows=$(tput lines)


for ((i=0; i<=cols-7; i++)); do
    clear
    printf "%${i}s8====D\n"
    sleep 0.05
done


clear

bye_msg="BYE BYE"
bye_length=${#bye_msg}
bye_col=$(( (cols - bye_length) / 2 ))
bye_row=$(( rows / 2 ))

tput cup $bye_row $bye_col
echo "$bye_msg"
sleep 1


exit 0
