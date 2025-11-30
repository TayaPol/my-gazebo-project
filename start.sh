#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

export GAZEBO_MODEL_PATH="$SCRIPT_DIR/models:$SCRIPT_DIR/aruco_models:/usr/share/gazebo-11/models"
export GAZEBO_RESOURCE_PATH="$SCRIPT_DIR/textures:$SCRIPT_DIR/aruco_models/materials:/usr/share/gazebo-11"
export GAZEBO_PLUGIN_PATH="$SCRIPT_DIR/plugins:/usr/lib/x86_64-linux-gnu/gazebo-11/plugins"

sed -i.bak "s|model://aruco_models/materials/scripts|file://$SCRIPT_DIR/aruco_models/materials/scripts|g" "$SCRIPT_DIR/aruco_field.world"
sed -i.bak "s|model://aruco_models/materials/textures|file://$SCRIPT_DIR/aruco_models/materials/textures|g" "$SCRIPT_DIR/aruco_field.world"

echo "=== Starting Gazebo ==="
gazebo "$SCRIPT_DIR/aruco_field.world"

mv "$SCRIPT_DIR/aruco_field.world.bak" "$SCRIPT_DIR/aruco_field.world"
