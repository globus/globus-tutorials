# 1. Activate the Python environment
source ~/.portal/bin/activate

# 2. Install dependent libs
pip install django-extensions Werkzeug pyopenssl cookiecutter

# 3. Point cookiecutter to the Globus portal repository
cookiecutter https://github.com/globus/cookiecutter-django-globus-app

# 4. Move to the portal base dir
cd ./<project_slug>

# 5. Install dependent libs
pip install -r requirements.txt



# Enable social_django and django_extensions apps
python manage.py migrate

# Copy static resources
python manage.py collectstatic

# Run the Globus portal
python manage.py runserver_plus 0.0.0.0:8443 \
--cert-file /opt/ssl/globusdemo.org.cert \
--key-file /opt/ssl/globusdemo.org.key \
--keep-meta-shutdown
