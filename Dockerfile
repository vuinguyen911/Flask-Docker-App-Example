# syntax=docker/dockerfile:1

FROM python:3.9-slim

WORKDIR /facevox-api-workdir

#
RUN mkdir -p /data/certbot/www data/certbot/conf


# Copy the requirements file into the container
COPY requirements.txt .

# Install any necessary dependencies
#RUN apt -y update && apt -y upgrade
#RUN apt -y install libopencv-dev
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Define the command to run the application
CMD [ "python", "app.py"]
