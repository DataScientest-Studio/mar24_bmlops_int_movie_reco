#!/bin/sh

# Check if the data file exists in the volume, if not copy from the initial data
if [ ! -f /app/src/data/data/processed/movie_matrix.csv ]; then
    echo "Data file not found in volume. Copying initial data..."
    mkdir -p /app/src/data/data/processed
    cp /app/init_data/movie_matrix.csv /app/src/data/data/processed/movie_matrix.csv
    cp /app/init_data/user_matrix.csv /app/src/data/data/processed/user_matrix.csv
else
    echo "Data file already exists in volume."
fi

# Check if the data file exists in the volume, if not copy from the initial data
if [ ! -f /app/models/model.pkl ]; then
    echo "Data file not found in volume. Copying initial data..."
    mkdir -p /app/models/model.pkl
    cp /app/init_data/model.pkl /app/models/model.pkl
    echo "Data file already exists in volume."
fi

# Start the application
exec "$@"
