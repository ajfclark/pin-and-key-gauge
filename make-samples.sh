#!/bin/bash

TYPES=$(jq -r '.parameterSets | keys[]' pin-and-key-gauge.json)

for TYPE in $TYPES
do
	openscad -o sample/$TYPE.stl -p pin-and-key-gauge.json -P $TYPE pin-and-key-gauge.scad
done
