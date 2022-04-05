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

# 6. Update the Django `settings.py` file and add `django_extensions` app.
# Edit `~/<project_slug>/<project_slug>/settings/base.py` and add ``django_extensions',` to `INSTALLED_APPS`.

# 7. Complete the configuration
python manage.py migrate
python manage.py collectstatic

# 8. Run the Globus portal!
python manage.py runserver_plus 0.0.0.0:8443 \
--cert-file /opt/ssl/globusdemo.org.cert \
--key-file /opt/ssl/globusdemo.org.key \
--keep-meta-shutdown
