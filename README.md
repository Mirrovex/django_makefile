# Makefile for quick start django project

to use type: make django <project_name> or make project <project_name>

# Makefile for Quick Start Django Project

This Makefile provides a set of commands for quickly start and a Django project.

## Usage

To use type: ```bashmake django <project_name>``` or ```bashmake project <project_name>```

## Features
### This Makefile automates the following tasks:
* starts new project with <project_name>
* creates .env (with SECRET_KEY) and .env.example files
* creates .gitignore file with .env, bin/, lib/, *.sqlite3, \_\_pycache\_\_/
* creates Makefile in project folder wchich contains
    * `make migrations` (makemigrations)
    * `make migrate` (migrate)
    * `make admin` (createsuperuser)
    * `make app <app_name>`
        * creates new app with <app_name>
        * add urls.py to app
        * add app to INSTALED_APPS
        * add <app_name>.urls to <project_name>/urls.py as include
    * `make up` (runserver)
    * `make shell` (shell)
* creates requirements.txt with my most frequently used packages
* import packages to settings
* change SECRET_KEY to get from .env
* change DEBUG to get from .env
* change ALLOWED_HOSTS to all
* add url connection to DATABASES
* add include to urls.py

## Getting Started
1. Clone the repository.
2. Navigate to the project folder.
3. Run make django <project_name> to start a new Django project.