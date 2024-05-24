# Makefile for quick start django project

to use type: make django <project_name> or make project <project_name>

## This makefile:
- starts new project with <project_name>
- creates .env (with SECRET_KEY) and .env.example files
- creates .gitignore file with .env, bin/, lib/, *.sqlite3, __pycache__/
- creates Makefile in project folder wchich contains
    - make migrations (makemigrations)
    - make migrate (migrate)
    - make admin (createsuperuser)
    - make app <app_name>
        - creates new app with <app_name>
        - add urls.py to app
        - add app to INSTALED_APPS
        - add <app_name>.urls to <project_name>/urls.py as include
    - make up (runserver)
    - make shell (shell)
- creates requirements.txt with my most frequently used packages
- import packages to settings
- change SECRET_KEY to get from .env
- change DEBUG to get from .env
- change ALLOWED_HOSTS to all
- add url connection to DATABASES
- add include to urls.py