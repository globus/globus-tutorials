# Set the base dir for the Django project
export PROJECT_SLUG="<YOUR_NAME>"

# 1. Activate the Python environment
source ~/.portal/bin/activate

# 2. Point cookiecutter to the Globus portal repository
cookiecutter https://github.com/globus/cookiecutter-django-globus-app

# 3. Move to the portal base dir
cd ~/$PROJECT_SLUG

# 4. Install dependent libs
pip install -r requirements.txt

# 5. Update the Django `settings.py` file and add `django_extensions` app.
# Edit `~/$PROJECT_SLUG/$PROJECT_SLUG/settings/base.py` and add ``django_extensions',` to `INSTALLED_APPS`.

# 6. Complete the configuration
python manage.py migrate
python manage.py collectstatic

# 7. Run the Globus portal!
python manage.py runserver_plus 0.0.0.0:8443 \
--cert-file /opt/ssl/globusdemo.org.cert \
--key-file /opt/ssl/globusdemo.org.key \
--keep-meta-shutdown
