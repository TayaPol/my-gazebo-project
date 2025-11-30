cmake_minimum_required(VERSION 3.0.2)
project(my_clover_description)

find_package(catkin REQUIRED COMPONENTS
  gazebo_ros
  xacro
  clover_description
)

catkin_package()