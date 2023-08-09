setup:
	@echo "Setting up virtual environment"
	python -m venv .env

install:
	@echo "Installing dependencies"
	pip install --upgrade pip  &&\
		pip install -r requirements.txt

format:
	@echo "Formating code with black"
	black webapp/*.py

lint:
	@echo "Liting code with  ruff pylint --disable=R,C *.py"
	ruff check webapp/*.py

run-app:
	@echo "Running local app with uvicorn"
	uvicorn webapp.main:app --host 0.0.0.0 

docker-build:
	@echo "Building Docker container"
	docker build -t webapp .

docker-run:
	@echo "Starting Docker container"
	docker run webapp python 

all: install format lint