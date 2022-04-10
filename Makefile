MAIN = main
CONTAINER = app
VENV = .venv
PYTHON = $(VENV)/bin/python3
PIP = $(VENV)/bin/pip


# Setup and run
setup: requirements.txt
	python3 -m venv $(VENV)
	$(VENV)/bin/pip install -r requirements.txt

activate: $(VENV)/bin/activate
	$(VENV)/bin/activate

run:
	uvicorn app.$(MAIN):app --reload


# Deployment
dev:
	docker build -f ./dockerfiles/Dockerfile.dev -t $(CONTAINER)-dev .
	docker run --rm -l debug $(CONTAINER)-dev

prod:
	docker build -f ./dockerfiles/Dockerfile -t $(CONTAINER) .
	docker run --rm -l debug $(CONTAINER)

# Maintenence
clean:
	find . -name __pycache__ | xargs rm -rf 
	rm -r $(VENV)

system-clean:
	docker system prune -a

.PHONY: run clean system-clean prod dev setup venv activate
