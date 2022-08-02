# Perform common tasks using the Globus Command Line Interface (CLI)
# Note: Commands typically require UUIDs to identify resources (collections, users, etc.)

export SOURCE="" 

# Find endpoint using text search
globus endpoint search 'RMACC22 Tutorial'

# List my tasks
globus task list

# Find identity ID (and/or identity name)
globus get-identities YOUR_IDENTITY_NAME
globus get-identities bfc122a3-af43-43e1-8a41-d36f28a2bc0a

# Transfer data to a guest collection for sharing
export SRC=937e7d0e-bb6f-4ac6-ab65-db41f2030e93   # RMACC22 Images on S3
export DST=fbe5da5e-4c2a-40f0-a1fe-948562f44065   # RMACC22 Tutorial Guest Collection
globus transfer --recursive $SRC:/carousel $DST:/cli/images/YOUR_NAME

# Get details about the transfer task
globus task show TRANSFER_TASK__UUID

# Grant a user "READ" permission on the guest collection; path must end with a trailing slash
globus endpoint permission create --permissions r --identity demodoc@globusid.org $DST:/cli/images/YOUR_NAME/
globus endpoint permission list $DST
globus endpoint permission delete $DST PERMISSION_UUID

# Search using filters
globus endpoint search --filter-scope my-endpoints

# Set command output to JSON
globus endpoint search --filter-scope my-endpoints --format json

# Parse endpoint results using a JMESPath query
globus endpoint search --filter-scope recently-used --jmespath 'DATA[].[id, display_name]'

### EOF
