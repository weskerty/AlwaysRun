#!/bin/bash

start_time=$(date +%s)


while true; do

    current_time=$(date +%s)
    elapsed_time=$((current_time - start_time))

    echo -ne "\rTime RUN $elapsed_time s"


    sleep 1
done
