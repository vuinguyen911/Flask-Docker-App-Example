# Flask-Docker-App

## Set up & Installation.

### 1 .Clone/Fork the git repo and create a virtual environment 
                    
**Windows**
          
```bash
git clone https://github.com/Dev-Elie/Flask-Docker-App.git
cd Flask-Docker-App
py -3 -m venv venv

```
          
**macOS/Linux**
          
```bash
git clone https://github.com/Dev-Elie/Flask-Docker-App.git
cd Flask-Docker-App
python3 -m venv venv

```
### 2 .Activate the environment
          
**Windows** 

```venv\Scripts\activate```
          
**macOS/Linux**

```. venv/bin/activate```
or
```source venv/bin/activate```


### 3 .Install the requirements

Applies for windows/macOS/Linux

```
pip install -r requirements.txt
```

### 5. Run the application
`python app.py`

# OR

## Create a new application from scratch

### 1. Create a directory with a name **"Flask-Docker-App"**
`mkdir Flask-Docker-App`

### 2. Navigate to the newly created directory

`cd Flask-Docker-App`

### 3. Create a virtual environment

**Windows**

`py -3 -m venv venv`
<br>

**macOS/Linux**

`python3 -m venv venv`

### 4. Activate the environment
          
**Windows** 

```venv\Scripts\activate```
          
**macOS/Linux**

```. venv/bin/activate```
or
```source venv/bin/activate```

### 3 .Install Flask

`pip install Flask`

### 4. Create the required files
Create two files; **app.py** and **Dockerfile**

`touch app.py Dockerfile`

## Congratulations! You can now proceed with the article on Dockerizing a Flask app [here](https://www.freecodecamp.org/news/how-to-dockerize-a-flask-app/).

</br>
<div align="center"><h1>Follow me on Twitter</h1></div>
<p align="center"> <a href="https://twitter.com/dev_elie" target="blank"><img src="https://img.shields.io/twitter/follow/dev_elie?logo=twitter&style=for-the-badge" alt="dev_elie" /></a> </p>

// update
Step 1: Build and Run the Docker Container
Build the Docker image:

bash
Copy code
docker build -t flask-api .
Run the Docker container:

bash
Copy code
docker run -d --name my_flask_api -p 1069:1069 flask-api
Here:
-d runs the container in detached mode (in the background).
--name my_flask_api names the container my_flask_api.
-p 5000:5000 maps port 5000 on your host to port 5000 on the container.
flask-api is the name of the image.

Step 2: Pause the Docker Container
To pause the container, use the following command:

bash
Copy code
docker pause my_flask_api
This will suspend all processes in the specified container.

Step 3: Unpause the Docker Container
To unpause the container and resume its processes, use:

bash
Copy code
docker unpause my_flask_api
Additional Commands
Check the status of your containers:

bash
Copy code
docker ps -a
This command will list all containers, showing their status (running, paused, exited, etc.).

Stop the container:

bash
Copy code
docker stop my_flask_api
Remove the container:

bash
Copy code
docker rm my_flask_api
Remove the image:

bash
Copy code
docker rmi flask-api

If you are using Docker Compose, you can build and run the container with:

bash
Copy code
docker-compose up --build
Step 5: Test the API
Once the container is running, you can test the API by navigating to http://localhost:5000/api in your web browser or using a tool like Postman or curl.

bash
Copy code
curl http://localhost:5000/api
You should receive a JSON response:

json
Copy code
{
    "message": "Hello, World!"
}
Summary
This guide provides a basic framework for creating and running a Dockerized Flask API. You can expand upon this by adding more routes, integrating a database, or using other Flask extensions as needed. Docker Compose is particularly useful for managing complex applications with multiple containers, such as those involving separate frontend and backend services, databases, and other dependencies.

