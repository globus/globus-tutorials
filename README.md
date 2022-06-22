# Globus Tutorial Sample Code and Command Cheatsheet

## Globus Connect Server
Here are links to commands for installing and configuring Globus Connect Server v5.

1. Register a Globus Connect Server at https://developers.globus.org. Before starting the installation, make sure you have the client ID and secret for your registered Globus Connect Server.
2. Install the endpoint and configure it using [the commands here](gcs-commands.sh).

## Globus Portal
Here are links to sample code and commands for deploying and customizing the Globus portal framework.

1. Register a Globus Auth client at https://developers.globus.org. Before continuing, make sure you have the client ID and secret for your registered application.
2. Deploy the portal framework using [the commands here](portal-setup-commands.sh).

To customize the portal configuration to use the alternative sample data search index:
1. Edit `~/$PROJECT_SLUG/$PROJECT_SLUG/settings/search.py` (make a backup copy first, so you can revert later). Replace the `SEARCH_INDEXES` field with the contents of [search.py](search.py).
2. Replace `~/$PROJECT_SLUG/$PROJECT_SLUG/fields.py` with the contents of [fields.py](fields.py).
3. Replace `~/$PROJECT_SLUG/templates/globus-portal-framework/v2/detail-overview.html` with the contents of [detail-overview.html](templates/globus-portal-framework/v2/detail-overview.html).
4. Replace `~/$PROJECT_SLUG/templates/globus-portal-framework/v2/components/search-results.html` with the contents of [search-results.html](templates/globus-portal-framework/v2/components/search-results.html).
