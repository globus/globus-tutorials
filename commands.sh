# Enable social_django and django_extensions apps
python manage.py migrate

# Copy static resources
python manage.py collectstatic

# Run the portal server
python manage.py runserver_plus 0.0.0.0:8443 --cert-file scN.globusdemo.org.cert --key-file scN.globusdemo.org.key
