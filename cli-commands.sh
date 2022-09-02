# Perform common tasks using the Globus Command Line Interface (CLI)
# Note: Commands require UUIDs to identify resources (collections, users, etc.)

# Find endpoint(s) using text search
globus endpoint search SEARCH_TEXT

# Search using filters; lists endpoints on which you have the administrator role
globus endpoint search --filter-scope administered-by-me

# List my tasks
globus task list

# Find identity ID (and/or identity name)
globus get-identities YOUR_IDENTITY_NAME
globus get-identities a52dd84e-d274-11e5-9b46-e71051162fd5

# Transfer data to a guest collection for sharing
export SRC=937e7d0e-bb6f-4ac6-ab65-db41f2030e93   # Tutorial Guest Collection on S3
export DST=a6f165fa-aee2-4fe5-95f3-97429c28bf82   # Globus Tutorials on ALCF Eagle
globus transfer --recursive $SRC:/carousel $DST:/cli/images/YOUR_NAME

# Get details about the transfer task
globus task show TRANSFER_TASK_UUID

# Grant a user "READ" permission on the guest collection; path must end with a trailing slash
globus endpoint permission create --permissions r --identity demodoc@globusid.org $DST:/cli/images/YOUR_NAME/
globus endpoint permission list $DST
globus endpoint permission delete $DST PERMISSION_UUID

# Set command output to JSON
globus endpoint search --filter-scope my-endpoints --format json

# Parse endpoint results using a JMESPath query
globus endpoint search --filter-scope recently-used --jmespath 'DATA[].[id, display_name]'

### EOF