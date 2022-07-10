# Perform common tasks using the Globus Command Line Interface (CLI)
# Note: Commands typically require UUIDs to identify resources (collections, users, etc.)

export SOURCE="" 

# Find endpoint using text search
globus endpoint search 'PEARC22 Tutorial'

# List my tasks
globus task list

# Find identity ID (and/or identity name)
globus get-identities YOUR_IDENTITY_NAME
globus get-identities bfc122a3-af43-43e1-8a41-d36f28a2bc0a

# Create the endpoint
export SRC=584ccac3-5124-4c0d-85c9-62848d503f70   # PEARC22 Tutorial Guest Collection
export DST=234360bb-0085-486c-85eb-2636eb169c23   # PEARC22 Tutorial on S3
globus transfer --recursive $SRC:/cli/carousel $DST:/images/YOUR_NAME

# Get details about a transfer task
globus task show TRANSFER_TASK__UUID

# Grant a user "READ" permission on the guest collection
globus endpoint permission create --permissions r --identity demodoc@globusid.org $DST:/images/YOUR_NAME/
globus endpoint permission list $DST
globus endpoint permission delete $DST PERMISSION_UUID

# Search using filters
globus endpoint search --filter-scope my-endpoints

# Set command output to JSON
globus endpoint search --filter-scope my-endpoints --format json

# Parse endpoint results using a JMESPath query
globus endpoint search --filter-scope recently-used --jmespath 'DATA[].[id, display_name]'
