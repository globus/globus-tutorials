# Commands for installing a portal using the Django Globus Portal Framework
# https://github.com/globus/django-globus-portal-framework

# Register an app with Globus Auth:
# https://app.globus.org/settings/developers/registration/confidential_client
# Use the following redirect URLs and get your client ID and secret
# Important: Replace "N" with the number of your EC2 instance
https://tutN.globusdemo.org:8443/
https://tutN.globusdemo.org:8443/complete/globus/

# 1. Activate the Python environment
source ~/.portal/bin/activate

# 2. Point cookiecutter to the Globus portal repository
# cookiecutter https://github.com/globus/cookiecutter-django-globus-app
cookiecutter https://github.com/vasv/django-globus-app-tutorial.git

# Repond to the prompts as follows:
  [1/11] project_name (Globus Portal): <YOUR_PORTAL_NAME>
  [2/11] project_slug (django_vas): <YOUR_PORTAL_NAME>
  [3/11] description (A web app for managing project data): <ANY_DESCRIPTION>
  [4/11] author_name (researcher): 
  [5/11] email (researcher@gateway.org):
  [6/11] version (0.1.0):
  [7/11] globus_client_id (f44c948b-8aa5-4881-85c5-e0a2300d96c4): <YOUR_REGISTERED_CLIENT_ID>
  [8/11] globus_secret_key (ScsmAsf/0yhP9/uI1vxAsmuRywWW1JLgCbxyKsnd0u8=): <YOUR_CLIENT_SECRET>
  [9/11] globus_search_index (6be80847-70f9-4441-9075-f9348d6b044a): c488d4a6-d0ee-4281-972b-5912371901ea
  [10/11] globus_portal_endpoint_id (a6f165fa-aee2-4fe5-95f3-97429c28bf82): fe2feb64-4ac0-4a40-ba90-94b99d06dd2c

export PROJECT_SLUG="YOUR_PORTAL_NAME"

# 3. Move to the portal base dir
cd ~/$PROJECT_SLUG

# 4. Install dependent libs
pip install -r requirements.txt

# 5. Update the Django `settings.py` file and add `django_extensions` app.
# NOTE: This is only required for running on EC2 instances using SSL
# Edit ~/$PROJECT_SLUG/$PROJECT_SLUG/settings/base.py and add 'django_extensions', to INSTALLED_APPS list.

# 6. Complete the configuration
python manage.py migrate
python manage.py collectstatic

# 7. Run the Globus portal!
python manage.py runserver_plus 0.0.0.0:8443 \
--cert-file /opt/ssl/globusdemo.org.crt \
--key-file /opt/ssl/globusdemo.org.key \
--keep-meta-shutdown

# Customizing the portal to use an alternative search index
# Before proceeding, make sure the steps above resulted in a fully-working portal

# 1. Edit ~/$PROJECT_SLUG/$PROJECT_SLUG/settings/search.py
# Replace the SEARCH_INDEXES field with the contents of search.py:
# https://github.com/globus/globus-tutorials/blob/main/search.py
# (make a backup copy first, so you can revert later, if needed)
cp ~/$PROJECT_SLUG/$PROJECT_SLUG/settings/search.py \
~/$PROJECT_SLUG/$PROJECT_SLUG/settings/search.py_ORIGINAL

# 2. Replace ~/$PROJECT_SLUG/$PROJECT_SLUG/fields.py with fields.py:
# https://github.com/globus/globus-tutorials/blob/main/fields.py
# (make a backup copy first, so you can revert later, if needed)
cp ~/$PROJECT_SLUG/$PROJECT_SLUG/fields.py \
~/$PROJECT_SLUG/$PROJECT_SLUG/fields.py_ORIGINAL

# 3. Replace ~/$PROJECT_SLUG/templates/globus-portal-framework/v2/detail-overview.html
# with the contents of detail-overview.html:
# https://github.com/globus/globus-tutorials/blob/main/templates/globus-portal-framework/v2/detail-overview.html
# (make a backup copy first, so you can revert later, if needed)
cp ~/$PROJECT_SLUG/templates/globus-portal-framework/v2/detail-overview.html \
~/$PROJECT_SLUG/templates/globus-portal-framework/v2/detail-overview.html_ORIGINAL

# 4. Replace ~/$PROJECT_SLUG/templates/globus-portal-framework/v2/components/search-results.html 
# with the contents of search-results.html:
# https://github.com/globus/globus-tutorials/blob/main/templates/globus-portal-framework/v2/components/search-results.html
# (make a backup copy first, so you can revert later, if needed)
cp ~/$PROJECT_SLUG/templates/globus-portal-framework/v2/components/search-results.html \
~/$PROJECT_SLUG/templates/globus-portal-framework/v2/components/search-results.html_ORIGINAL

### EOF
