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

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install Docker
install_docker() {
    echo "Installing Docker 25.0.5..."
    # Remove any old versions
    sudo yum remove docker docker-engine docker.io containerd runc

    # Update the apt package index and install packages to allow apt to use a repository over HTTPS:
    sudo yum update
    sudo yum install -y \
        ca-certificates \
        curl \
        gnupg

    # Add Docker’s official GPG key:
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    # Set up the repository:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Install Docker Engine
    sudo yum update
    sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    echo "Docker 25.0.5 installed successfully."
}

# Function to install Certbot
install_certbot() {
    echo "Installing Certbot..."
    sudo yum update
    sudo yum install -y certbot
    echo "Certbot installed successfully."
}

# Function to setup SSL certificate with Certbot
setup_certbot() {
    echo "Setting up SSL certificate with Certbot..."
    sudo certbot certonly --standalone -d test.facevox.jp --email vnv1004@gmail.com --agree-tos --non-interactive
    echo "SSL certificate setup completed."
}

# Function to clone the GitHub repository
clone_repository() {
    echo "Cloning GitHub repository..."
    if [ ! -d "Flask-Docker-App-Example" ]; then
        git clone -b main https://github.com/vuinguyen911/Flask-Docker-App-Example.git
    else
        echo "Repository already exists. Pulling the latest changes..."
        cd Flask-Docker-App-Example && git pull origin main && cd ..
    fi
    echo "GitHub repository cloned successfully."
}

# Function to download model from remote URL
download_model() {
    MODEL_URL="https://path.to/your/model"
    MODEL_DIR="Flask-Docker-App-Example/model"
    echo "Downloading model from remote URL..."
    mkdir -p "$MODEL_DIR"
    curl -o "$MODEL_DIR/model.file" "$MODEL_URL"
    echo "Model downloaded successfully."
}

# Function to build and start Docker Compose services
start_docker_compose() {
    echo "Building and starting Docker Compose services..."
    cd Flask-Docker-App-Example
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

    # Check and install Certbot
    if command_exists certbot; then
        echo "Certbot is already installed."
    else
        install_certbot
    fi

    # Setup Certbot SSL certificate
    setup_certbot

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

