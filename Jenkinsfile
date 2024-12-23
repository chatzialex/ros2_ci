pipeline {
  agent any
  environment {
    IMAGE_NAME = 'chatzialex/ros2_ci:latest'
    CONTAINER_NAME = 'ros2_ci_1'
  }
  parameters {
    booleanParam(name: 'HEADLESS', defaultValue: false, description: 'Run tests in headless mode')
  }
  stages {
    stage('Build') {
      steps {
        script {
          sh "docker build --no-cache -t ${IMAGE_NAME} ."
        }
      }
    }
    stage('Test') {
      steps {
        sh """
          docker run --name ${CONTAINER_NAME} --rm -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME/.Xauthority:/root/.Xauthority -e DISPLAY=$DISPLAY --runtime=nvidia --gpus all --device /dev/dri ${IMAGE_NAME} launch_test --verbose src/tortoisebot_waypoints/test/waypoints_launch_test.py headless:=${params.HEADLESS}
        """
      }
    }
  }
}

