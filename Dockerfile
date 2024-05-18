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

# CMD to start the application
CMD ["uvicorn", "app.server:app", "--host", "0.0.0.0", "--port", "8000"]



