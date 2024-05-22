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

# Copy the initial data file
COPY ./app/src/data/data/processed/movie_matrix.csv /app/init_data/movie_matrix.csv
COPY ./app/src/data/data/processed/user_matrix.csv /app/init_data/user_matrix.csv
COPY ./app/models/model.pkl /app/models/model.pkl


# Copy the initialization script
COPY init.sh /app/init.sh
RUN chmod +x /app/init.sh

# VOLUME instruction to declare mount point
VOLUME /app/models
VOLUME /app/src/data/data

# CMD to start the application
ENTRYPOINT ["/app/init.sh"]
CMD ["uvicorn", "app.server:app", "--host", "0.0.0.0", "--port", "8000"]
