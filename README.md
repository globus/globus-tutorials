# Globus Tutorial Sample Code and Command Cheatsheet
Sample code and commands for deploying and configuring the Globus portal framework and other bits.

1. Before deploying the portal code register a  Globus Auth client at https://developers.globus.org
2. Deploy the portal framework using [the commands here](commands.sh)

To customize the portal configuration to use a different search index:
1. Edit `~/$PROJECT_SLUG/$PROJECT_SLUG/settings/search.py` (make a backup copy first, so you can revert later). Replace the `SEARCH_INDEXES` field with the contents of [search.py](search.py).
2. Replace `~/$PROJECT_SLUG/$PROJECT_SLUG/fields.py` with the contents of [fields.py](fields.py).
3. Replace `~/$PROJECT_SLUG/$PROJECT_SLUG/templates/globus-portal-framework/v2/detail-overview.html` with the contents of [detail-overview.html](detail-overview.html)
