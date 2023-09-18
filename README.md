# Sample Code and Command Cheatsheets for Globus Tutorials

We use the following resources throughout the tutorial:

#### Collections
* Globus Tutorials on ALCF Eagle (Note: Often down for maintenance)
   * Collection ID: a6f165fa-aee2-4fe5-95f3-97429c28bf82
   * HTTP Hostname: g-fe1c1.fd635.8443.data.globus.org 
* Tutorial Guest Collection
   * Collection ID: fe2feb64-4ac0-4a40-ba90-94b99d06dd2c
   * HTTP Hostname: g-13a6e8.f9e26.5898.data.globus.org

#### Groups
   * Tutorial Users group ID: 50b6a29c-63ac-11e4-8062-22000ab68755 (join for access to various tutorial resources)

#### Search Indices
   * FEMA data search index ID: 6be80847-70f9-4441-9075-f9348d6b044a (subjects point to Globus Tutorials on ALCF Eagle)
   * LADI data search index ID: c488d4a6-d0ee-4281-972b-5912371901ea (subjects point to Tutorial Guest Collection)

## Globus Connect Server Exercises
To install and configure Globus Connect Server v5 on your EC2 instance use [the commands here](gcs-commands.sh).

## Globus CLI Exercises
The Globus CLI is already installed on your instance and can be accessed via the `devN` local account.

1. Run `globus login` to authenticate.
2. Run [the commands here](cli-commands.sh) to transfer and share files.

## Globus Flows Exercises
You will need to configure and run a simple script that monitors the filesystem and triggers a Flow run. See [the commands here](flows-commands.sh).

## Globus Portal Exercises
To deploy a 'plain vanilla' instance of the Globus portal framework use [the commands here](portal-setup-commands.sh). This file also includes the redirect URLs you will need to register your portal with Globus Auth as a confidential client. [Register a Globus Auth confidential client](https://app.globus.org/settings/developers/registration/confidential_client) and make sure you have the client ID and secret for your registered application before continuing.

Instructions for customizing the portal configuration to use the alternative sample data search index:

1. Edit `~/$PROJECT_SLUG/$PROJECT_SLUG/settings/search.py` (make a backup copy first, so you can revert later, if needed). Replace the `SEARCH_INDEXES` field with the contents of [search.py](search.py).
2. Replace `~/$PROJECT_SLUG/$PROJECT_SLUG/fields.py` with the contents of [fields.py](fields.py).
3. Replace `~/$PROJECT_SLUG/templates/globus-portal-framework/v2/detail-overview.html` with the contents of [detail-overview.html](templates/globus-portal-framework/v2/detail-overview.html).
4. Replace `~/$PROJECT_SLUG/templates/globus-portal-framework/v2/components/search-results.html` with the contents of [search-results.html](templates/globus-portal-framework/v2/components/search-results.html).
