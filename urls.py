# Replaces ~/myportal/myportal/urls.py
#

from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    # Provides the basic search portal
    path('', include('globus_portal_framework.urls')),
    # Provides Login urls for Globus Auth
    path('', include('social_django.urls', namespace='social')),
]
