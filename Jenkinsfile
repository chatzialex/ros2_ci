pipeline {
  agent any
  environment {
    IMAGE_NAME = 'chatzialex/ros2_ci:latest'
    CONTAINER_NAME = 'ros2_ci_1'
  }
  stages {
    stage('Build') {
      steps {
        script {
          sh "docker build -t ${IMAGE_NAME} ."
        }
      }
    }
    stage('Test') {
      steps {
        sh """
          docker run --name ${CONTAINER_NAME} --rm -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME/.Xauthority:/root/.Xauthority -e DISPLAY=$DISPLAY --runtime=nvidia --gpus all --device /dev/dri ${IMAGE_NAME} colcon test --packages-select tortoisebot_waypoints --event-handler=console_direct+
        """
      }
    }
  }
}

