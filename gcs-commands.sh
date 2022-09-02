# Register a Globus Connect Server with Globus Auth: https://developers.globus.org
# Note the GCS client ID and secret; you will use it in multiple commands below

export CLIENT_ID="YOUR_GCS_CLIENT_ID"

# Create the endpoint
globus-connect-server endpoint setup \
'My Tutorial GCS Endpoint' \
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
'My Tutorial Storage Gateway' \
--domain globusid.org \
--authentication-timeout-mins 90

# Create a mapped collection on the storage gateway
globus-connect-server collection create STORAGE_GATEWAY_ID / 'My Tutorial Mapped Collection'

# Create local user account (--> use the same name as your Globus identity <--)
adduser --disabled-password --gecos 'LOCAL_ACCOUNT_NAME' LOCAL_ACCOUNT_NAME

# Create a storage gateway with path restrictions
globus-connect-server storage-gateway create posix \
"My Tutorial Storage Gateway - Restricted" \
--domain globusid.org \
--authentication-timeout-mins 90 \
--restrict-paths file:/home/adminN/paths.json

# Create a mapped collection to access data via the restricted storage gateway
globus-connect-server collection create STORAGE_GATEWAY_ID / "My Tutorial Mapped Collection – Restricted"

# Make endpoint "managed" ...or ask the Globus team to do it
globus-connect-server endpoint set-subscription-id YOUR_SUBSCRIPTION_ID

# Allow sharing on mapped collection
globus-connect-server collection update COLLECTION_ID --allow-guest-collections

# Allow browser-based HTTPS uploads and downloads
globus-connect-server collection update COLLECTION_ID --enable-https

# Setting the default directory for a collection
# Note: $USER is not a shell variable; it has special meaning to GCS
globus-connect-server collection update COLLECTION_ID --default-directory '/home/$USER/'

# Adding nodes (DTNs) to an endpoint
globus-connect-server node setup $CLIENT_ID --deployment-key ENDPOINT_DEPLOYMENT_KEY
systemctl restart apache2

# Migrating nodes
# Save node configuration on existing DTN to a file
globus-connect-server node setup $CLIENT_ID \
--deployment-key ENDPOINT_DEPLOYMENT_KEY \
--export-node NODE_CONFIG_FILENAME

# Restore node configuration from file on new DTN
globus-connect-server node setup $CLIENT_ID \
--deployment-key ENDPOINT_DEPLOYMENT_KEY \
--import-node NODE_CONFIG_FILENAME

# Creating a storage gateway to access AWS S3 buckets
globus-connect-server storage-gateway create s3 \
'My Tutorial S3 Storage Gateway' \
--domain 'uchicago.edu' \
--s3-endpoint https://s3.amazonaws.com \
--bucket MY_BUCKET \
--s3-user-credential

# Create a mapped collection to access AWS S3 buckets
globus-connect-server collection create STORAGE_GATEWAY_ID / 'My Tutorial S3 Collection'

# Deleting the endpoint requires multiple steps
# Run the follwoing two commands in the order shown
globus-connect-server node cleanup
globus-connect-server endpoint cleanup --client-id $CLIENT_ID --deployment-key deployment-key.json

### EOF