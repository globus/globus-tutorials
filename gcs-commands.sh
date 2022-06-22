# Register a Globus Connect Server with Globus Auth: https://developers.globus.org
# Note the GCS client ID and secret; you will use it in multiple commands below

export CLIENT_ID="c7acf097-9f85-4d3c-b6ad-aebde31f1e59"

# Create the endpoint
globus-connect-server endpoint setup \
'My Endpoint' \
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

# Create a storage gateway to access a POSIX-compliant system
globus-connect-server storage-gateway create posix \
'My Storage Gateway' \
--domain globusid.org \
--authentication-timeout-mins 90

# Create a mapped collection on the storage gateway
globus-connect-server collection create STORAGE_GATEWAY_ID / 'My Mapped Collection'

# Create local user account (use the same name as your Globus identity)
adduser --disabled-password --gecos 'LOCAL_ACCOUNT_NAME' LOCAL_ACCOUNT_NAME

# Create a storage gateway with path restrictions
globus-connect-server storage-gateway create posix \
"My Storage Gateway - Restricted" \
--domain globusid.org \
--authentication-timeout-mins 90 \
--restrict-paths file:/home/adminN/paths.json

# Create a mapped collection to access data via the restricted storage gateway
globus-connect-server collection create STORAGE_GATEWAY_ID / "My Mapped Collection – Restricted"

# Make endpoint "managed" ...or ask Globus team to do it
globus-connect-server endpoint set-subscription-id YOUR_SUBSCRIPTION_ID

# Allow sharing on mapped collection
globus-connect-server collection update COLLECTION_ID --allow-guest-collections

# Allow browser-based HTTPS uploads and downloads
globus-connect-server collection update COLLECTION_ID --enable-https

