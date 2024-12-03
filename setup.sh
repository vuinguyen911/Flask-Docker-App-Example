#!/bin/bash
# Giải thích script
#1. command_exists: Hàm kiểm tra xem một lệnh có tồn tại hay không.
#2. install_docker: Hàm để cài đặt Docker 25.0.5.
#3. install_certbot: Hàm để cài đặt Certbot.
#4. setup_certbot: Hàm để thiết lập chứng chỉ SSL với Certbot.
#5. clone_repository: Hàm để clone repository từ GitHub.
#6. download_model: Hàm để tải mô hình từ URL.
#7. start_docker_compose: Hàm để xây dựng và khởi động các dịch vụ Docker Compose.
# chmod +x setup.sh

#!/bin/bash

# Define variables
DOCKER_VERSION="latest"
DOCKER_COMPOSE_VERSION="2.23.0"
PROJECT_NAME="facevox_api"
# dev
#GITHUB_REPO="https://github.com/vuinguyen911/Flask-Docker-App-Example.git"
#GITHUB_BRANCH="main"
# honban
GITHUB_REPO="git@git.vtmlab.com:vtm-dev-group/kaoninshou.git"
GITHUB_BRANCH="facerec_faster_multi_customer"
MODEL_URL="http://212.183.159.230/"
MODEL_DIR="facevox_api/model"
DOMAIN="test.facevox.jp"
EMAIL="vnv1004@gmail.com"

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install Docker
install_docker() {
    echo "Installing Docker 25.0.5..."

    # Update the package index
    sudo yum update -y

    # Install Docker
    sudo yum install -y docker

    # Start Docker service
    sudo systemctl start docker

    # Enable Docker service to start on boot
    sudo systemctl enable docker

    # Add ec2-user to the docker group
    sudo usermod -aG docker ec2-user

    # echo "Docker 25.0.5 installed successfully."
}

# Function to verify Docker installation
verify_docker_installation() {
    if command_exists docker; then
        docker --version
        if [ $? -eq 0 ]; then
            echo "Docker installation verified successfully."
        else
            echo "Docker installation verification failed."
            exit 1
        fi
    else
        echo "Docker is not installed."
        exit 1
    fi
}

# Function to install Docker Compose
install_docker_compose() {
    echo "Installing Docker Compose from $DOCKER_COMPOSE_VERSION..."

    # Download Docker Compose binary
    sudo curl -L "https://github.com/docker/compose/releases/download/v$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

    # Apply executable permissions to the binary
    sudo chmod +x /usr/local/bin/docker-compose

    # Create a symbolic link to /usr/bin
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

    echo "Docker Compose $DOCKER_COMPOSE_VERSION installed successfully."
}

# Function to verify Docker Compose installation
verify_docker_compose_installation() {
    if command_exists docker-compose; then
        docker-compose --version
        if [ $? -eq 0 ]; then
            echo "Docker Compose installation verified successfully."
        else
            echo "Docker Compose installation verification failed."
            exit 1
        fi
    else
        echo "Docker Compose is not installed."
        exit 1
    fi
}



# Function to install Certbot
install_certbot() {
    echo "Installing Certbot..."
    sudo yum update
    sudo yum install -y certbot
    echo "Certbot installed successfully."
}

# Function to verify Docker installation
verify_certbot_installation() {
    if command_exists certbot; then
        certbot --version
        if [ $? -eq 0 ]; then
            echo "Certbot installation verified successfully."
        else
            echo "Certbot installation verification failed."
            exit 1
        fi
    else
        echo "Certbot is not installed."
        exit 1
    fi
}

# Function to setup SSL certificate with Certbot
setup_certbot() {
    echo "Setting up SSL certificate with Certbot..."
    sudo certbot certonly --standalone -d $DOMAIN --email $EMAIL --agree-tos --non-interactive
    echo "SSL certificate setup completed."
}

# Function to clone the GitHub repository
clone_repository() {
    echo "Cloning GitHub repository from $GITHUB_REPO..."
    if [ ! -d "facevox_api" ]; then
        git clone -b $GITHUB_BRANCH $GITHUB_REPO facevox_api
    else
        echo "Repository already exists. Pulling the latest changes..."
        cd facevox_api && git pull origin main && cd ..
    fi
    echo "GitHub repository cloned successfully."
}

# Function to download model from remote URL
download_model() {
    echo "Downloading model from remote URL..."
    mkdir -p "$MODEL_DIR"
    curl -o "$MODEL_DIR/10MB.zip" "$MODEL_URL"
    echo "Model downloaded successfully."
}

# Function to build and start Docker Compose services
start_docker_compose() {
    echo "Building and starting Docker Compose services..."
    cd $PROJECT_NAME
    docker-compose up -d --build
    echo "Docker Compose services started successfully."
}

# Main script execution
main() {
    echo "Starting setup..."

    # Check and install Docker
    if command_exists docker; then
        echo "Docker is already installed."
    else
        install_docker
    fi

    # verify docker after install
    verify_docker_installation

    # Check and install Docker Compose
    if command_exists docker-compose; then
        echo "Docker Compose is already installed."
        docker-compose --version
    else
        install_docker_compose
    fi

    # Verify Docker Compose installation
    verify_docker_compose_installation

    # Check and install Certbot
    if command_exists certbot; then
        echo "Certbot is already installed."
    else
        install_certbot
    fi

    # verify certbot after install
    verify_certbot_installation

    # Setup Certbot SSL certificate
#    setup_certbot

    # Clone the GitHub repository
    clone_repository

    # Download model from remote URL
    download_model

    # Build and start Docker Compose services
    start_docker_compose

    echo "Setup completed."
}

# Run the main function
main

