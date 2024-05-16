FROM python:3.11


WORKDIR /app


# Install external requirements from the root requirements.txt
COPY ./requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt


# Install local requirements from the app folder
COPY ./app/requirements.txt app/requirements.txt
RUN pip install --no-cache-dir -r app/requirements.txt


# Copy the necessary files of the application code
COPY ./app/server.py app/server.py
COPY ./app/src/models/predict_model.py app/src/models/predict_model.py


# Set up Volume mounts for storing data files
VOLUME /app/models
VOLUME /app/src/data/data

# Copy the CSV file into the Docker image
# COPY ./app/models/model.pkl app/models/model.pkl
# COPY ./app/src/data/data/processed/movie_matrix.csv app/src/data/data/processed/movie_matrix.csv
##


CMD ["uvicorn", "app.server:app", "--host", "0.0.0.0", "--port", "8000"]





