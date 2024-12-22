FROM osrf/ros:galactic-desktop

SHELL [ "/bin/bash" , "-c" ]

RUN apt-get update && apt-get install -y \
 ros-galactic-xacro \
 ros-galactic-joint-state-publisher \
 ros-galactic-gazebo-ros-pkgs \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /ros2_ws/src
RUN git clone --depth 1 --branch ros2-galactic https://github.com/chatzialex/tortoisebot.git /ros2_ws/src/tortoisebot
COPY tortoisebot_waypoints /ros2_ws/src/tortoisebot_waypoints

RUN source /opt/ros/galactic/setup.bash \
 && cd /ros2_ws \
 && colcon build

RUN sed -i '/exec "\$@"/i source /ros2_ws/install/setup.bash' /ros_entrypoint.sh
WORKDIR /ros2_ws
