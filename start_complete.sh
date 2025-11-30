#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

export GAZEBO_MODEL_PATH="$SCRIPT_DIR/models:$SCRIPT_DIR/aruco_models:/usr/share/gazebo-11/models"
export GAZEBO_RESOURCE_PATH="$SCRIPT_DIR/textures:$SCRIPT_DIR/aruco_models/materials:/usr/share/gazebo-11"
export GAZEBO_PLUGIN_PATH="$SCRIPT_DIR/plugins:/usr/lib/x86_64-linux-gnu/gazebo-11/plugins"

echo "=== Starting complete simulation ==="

if ! rostopic list > /dev/null 2>&1; then
    echo "Starting ROS core..."
    roscore &
    ROSCORE_PID=$!
    sleep 5
fi

echo "Starting Gazebo world..."
gazebo "$SCRIPT_DIR/aruco_field.world" &
GAZEBO_PID=$!

echo "Waiting for Gazebo to initialize..."
sleep 15

echo "Spawning drone..."
if rosrun gazebo_ros spawn_model -file "$SCRIPT_DIR/my_clover_description/urdf/clover4_standalone.urdf" -urdf -model clover4 -x 0 -y 0 -z 1.0; then
    echo "✓ Drone spawned successfully!"
else
    echo "✗ Failed to spawn drone - trying manual method..."

    rosrun gazebo_ros spawn_model -file "$SCRIPT_DIR/my_clover_description/urdf/clover4_standalone.urdf" -urdf -model clover4 -x 0 -y 0 -z 1.0 -unpause
fi
echo "=== Simulation ready ==="
echo "- ArUco markers with textures"
echo "- Moving car" 
echo "- Clover drone with model"
echo "Press Ctrl+C to stop"

wait $GAZEBO_PID