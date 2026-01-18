#!/bin/bash

if [ "$1" = "glm" ]; then
	cp ~/.claude/model-settings/glm-settings.json ~/.claude/settings.json
	echo "switch to glm!\n"
elif ["$1" = "fox"]; then
	cp ~/.claude/model-settings/foxcode-settings.json ~/.claude/settings.json
	echo "switch to fox!\n"
else 
	echo "No model match\n"
fi

