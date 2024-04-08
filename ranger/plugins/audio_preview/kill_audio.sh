#!/usr/bin/env bash
AUDIO_PID_FILE="./tmp/ranger-audio.pid"

if [ -f "${AUDIO_PID_FILE}" ]; then 
	kill -9 $(head -n 1 "${AUDIO_PID_FILE}") 
        rm "${AUDIO_PID_FILE}" 
fi
