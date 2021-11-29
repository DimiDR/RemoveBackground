
# Use the official lightweight Python image.
# https://hub.docker.com/_/python
#FROM python:3.9-slim
FROM python:3.9

ENV PORT 80
ENV HOST 0.0.0.0

EXPOSE 80

RUN apt-get update -y && \
    apt-get install -y python3-pip

RUN pip install --upgrade pip


# Allow statements and log messages to immediately appear in the Knative logs
ENV PYTHONUNBUFFERED True

# Copy local code to the container image.
ENV APP_HOME /app
WORKDIR $APP_HOME
#COPY . ./

COPY ./requirements.txt /app/requirements.txt

# Install production dependencies.
RUN pip install -r requirements.txt

COPY . /app

ENTRYPOINT ["python", "remove_background.py"]

# Run the web service on container startup. Here we use the gunicorn
# webserver, with one worker process and 8 threads.
# For environments with multiple CPU cores, increase the number of workers
# to be equal to the cores available.
# Timeout is set to 0 to disable the timeouts of the workers to allow Cloud Run to handle instance scaling.
# CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 remove_background:app
CMD exec gunicorn --bind :8080 --workers 1 --threads 8 --timeout 0 remove_background:app