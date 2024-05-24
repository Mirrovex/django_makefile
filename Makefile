django:
	django-admin startproject $(word 2, $(MAKECMDGOALS))
	cd $(word 2, $(MAKECMDGOALS)) && \
	\
	echo -e "\
	# DJANGO\n\
	DEBUG=True\n\
	DATABASE_URL=__PLACEHOLDER__\n\
	# DATABASE_URL=\n\
	SECRET_KEY=\x22$$(grep SECRET_KEY $(word 2, $(MAKECMDGOALS))/settings.py | sed 's/.*'\''\(.*\)'\''/\1/')\x22" > .env && \
	\
	echo -e "\
	# DJANGO\n\
	DEBUG=True\n\
	DATABASE_URL=__PLACEHOLDER__\n\
	SECRET_KEY=__PLACEHOLDER__" > .env.example && \
	\
	echo -e "\
	*.env\n\
	bin/\n\
	lib/\n\
	*.sqlite3\n\
	__pycache__/\n" > .gitignore && \
	\
	echo -e "\
	migrations:\n\
	\tpython manage.py makemigrations\n\n\
	migrate:\n\
	\tpython manage.py migrate\n\n\
	admin:\n\
	\tpython manage.py createsuperuser\n\n\
	app:\n\
	\tdjango-admin startapp \$$(word 2, \$$(MAKECMDGOALS))\n\
	\techo -e \x22from django.urls import path\x5Cn\x5Cn\x5C\n\
	\tfrom .views import *\x5Cn\x5Cn\x5Cn\x5C\n\
	\turlpatterns = [\x5Cn\x5C\n\
	\t\x5C\x74path('', home, name='home'),\x5Cn\x5C\n\
	\t]\x22 > \$$(word 2, \$$(MAKECMDGOALS))/urls.py\n\
	\tsed -i \x22/^INSTALLED_APPS\s*=/,/^\x5Cs*\x5C]/ s/^\x5C(\s*\x5C]\s*\x5C)\x24\x24/    '\$$(word 2, \$$(MAKECMDGOALS))',\x5Cn\x5C1/\x22 $(word 2, $(MAKECMDGOALS))/settings.py\n\
	\tsed -i \x22/^urlpatterns\s*=/,/^\x5Cs*\x5C]/ s/^\x5C(\s*\x5C]\s*\x5C)\x24\x24/	path('', include('\$$(word 2, \$$(MAKECMDGOALS)).urls')),\x5Cn\x5C1/\x22 $(word 2, $(MAKECMDGOALS))/urls.py\n\n\
	up:\n\
	\tpython manage.py runserver\n\n\
	shell:\n\
	\tpython manage.py shell" > Makefile && \
	\
	echo -e "\
	Django==5.0.3\n\
	djangorestframework==3.14.0\n\
	Pillow==9.2.0\n\
	dj-database-url==2.1.0\n\
	psycopg2-binary==2.9.9\n\
	python-dotenv==0.21.0" > requirements.txt

	sed -i "/^from pathlib import Path/c\from pathlib import Path\nimport os\nfrom dotenv import load_dotenv\nimport dj_database_url\n\nenv_path = '.env'\nload_dotenv(dotenv_path=env_path)\n" $(word 2, $(MAKECMDGOALS))/$(word 2, $(MAKECMDGOALS))/settings.py && \
	sed -i "/^SECRET_KEY = /c\SECRET_KEY = os.environ.get('SECRET_KEY')" $(word 2, $(MAKECMDGOALS))/$(word 2, $(MAKECMDGOALS))/settings.py && \
	sed -i "/^DEBUG = /c\DEBUG = os.environ.get('DEBUG').lower() == 'true'" $(word 2, $(MAKECMDGOALS))/$(word 2, $(MAKECMDGOALS))/settings.py && \
	sed -i "/^ALLOWED_HOSTS = /c\ALLOWED_HOSTS = ['*']" $(word 2, $(MAKECMDGOALS))/$(word 2, $(MAKECMDGOALS))/settings.py && \
	sed -i "/^DATABASES = {/,/^}/c\DATABASES = {\n    'default': {\n        'ENGINE': 'django.db.backends.sqlite3',\n        'NAME': BASE_DIR / 'db.sqlite3',\n    }\n}\nif os.environ.get('DATABASE_URL') != '__PLACEHOLDER__':\n    DATABASES['default'] = dj_database_url.parse(os.environ.get('DATABASE_URL'))" $(word 2, $(MAKECMDGOALS))/$(word 2, $(MAKECMDGOALS))/settings.py && \
	sed -i "/^INSTALLED_APPS\s*=/,/^\s*\]/ s/^\(\s*\]\s*\)$$/    \n\1/" $(word 2, $(MAKECMDGOALS))/$(word 2, $(MAKECMDGOALS))/settings.py

	sed -i "/^from django.urls import path/c\from django.urls import path, include" $(word 2, $(MAKECMDGOALS))/$(word 2, $(MAKECMDGOALS))/urls.py

project: django
