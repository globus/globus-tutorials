# Register an app with Globus Auth: https://developers.globus.org
# Use the following redirect URLs and get your client ID and secret
https://tutN.globusdemo.org:8443/
https://tutN.globusdemo.org:8443/complete/globus/

# 1. Activate the Python environment
source ~/.portal/bin/activate

# 2. Point cookiecutter to the Globus portal repository
cookiecutter https://github.com/globus/cookiecutter-django-globus-app

export PROJECT_SLUG="YOUR_PORTAL_SHORT_NAME"

# 3. Move to the portal base dir
cd ~/$PROJECT_SLUG

# 4. Install dependent libs
pip install -r requirements.txt

# 5. Update the Django `settings.py` file and add `django_extensions` app.
# Edit ~/$PROJECT_SLUG/$PROJECT_SLUG/settings/base.py and add 'django_extensions', to INSTALLED_APPS list.

# 6. Complete the configuration
python manage.py migrate
python manage.py collectstatic

# 7. Run the Globus portal!
python manage.py runserver_plus 0.0.0.0:8443 \
--cert-file /opt/ssl/globusdemo.org.crt \
--key-file /opt/ssl/globusdemo.org.key \
--keep-meta-shutdown
