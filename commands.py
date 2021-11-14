# Edit ~/myportal/myportal/settings.py

# Paste your registered client ID and secret
SOCIAL_AUTH_GLOBUS_KEY = 'YOUR_CLIENT_ID'
SOCIAL_AUTH_GLOBUS_SECRET = 'YOUR_SECRET'

# Add your server to the ALLOWED_HOSTS list
ALLOWED_HOSTS = [
    'scN.globusdemo.org',
]

# Add django_extensions to the INSTALLED_APPS list
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'globus_portal_framework',
    'social_django',
    'django_extensions',
]

# Copy static resources
python manage collectstatic

# Run the portal server
python manage.py runserver_plus 0.0.0.0:8443 --cert-file scN.globusdemo.org.cert --key-file scN.globusdemo.org.key
