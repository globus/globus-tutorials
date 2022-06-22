# Register a Globus Connect Server with Globus Auth: https://developers.globus.org
# Note the GCS client ID and secret; you will use it in multiple commands below

export CLIENT_ID="c7acf097-9f85-4d3c-b6ad-aebde31f1e59"

# Create the endpoint
globus-connect-server endpoint setup \
'GlobusWorld Tour Tutorial Endpoint' \
--organization YOUR_ORGANIZATION_NAME \
--client-id $CLIENT_ID \
--contact-email YOUR_EMAIL_ADDRESS \
--owner GLOBUS_IDENTITY_USED_TO_REGISTER_GCS_CLIENT

# Add this server as a DTN on the endpoint
globus-connect-server node setup --client-id $CLIENT_ID

# Activate endpoint configuration
systemctl restart apache2

# Log into the GCS manager service on this server
globus-connect-server login localhost

# Get information about the endpoint
globus-connect-server endpoint show

