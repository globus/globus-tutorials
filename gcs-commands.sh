# Commands for installing and configuring Globus Connect Server

# ------- Creating the endpoint -------
globus-connect-server endpoint setup \
'My Tutorial Endpoint' \
--organization YOUR_ORGANIZATION_NAME \
--contact-email YOUR_EMAIL_ADDRESS \
--owner GLOBUS_IDENTITY   # must be known to Globus Auth; log in at least once

# Add this server as a DTN on the endpoint
sudo globus-connect-server node setup

# You may be prompted to explicitly provide the IP address of the node
# Get this by running: dig YOUR_SERVER_DNS_NAME
# Run the node setup command as follows
sudo globus-connect-server node setup --ip-address YOUR_NODE_IP_ADDRESS

# Activate endpoint configuration
sudo systemctl reload apache2

# Log into the GCS manager service on this server
globus-connect-server login localhost

# Get information about the endpoint
globus-connect-server endpoint show


# ------- Enabling data access ------- 
# Create a storage gateway to access a POSIX-compliant system
globus-connect-server storage-gateway create posix \
'My Tutorial Storage Gateway' \
--domain globusid.org \
--authentication-timeout-mins 90

# Create a mapped collection on the storage gateway
globus-connect-server collection create STORAGE_GATEWAY_ID \
/ \
'My Tutorial Mapped Collection'

# Create local user account (--> use the same name as your Globus identity <--)
adduser --disabled-password --gecos 'LOCAL_ACCOUNT_NAME' LOCAL_ACCOUNT_NAME


# ------- Configuring GCS -------
# Create a storage gateway with path restrictions
globus-connect-server storage-gateway create posix \
"My Tutorial Storage Gateway - Restricted" \
--domain globusid.org \
--authentication-timeout-mins 90 \
--restrict-paths file:/home/adminN/paths.json

# Create a mapped collection to access data via the restricted storage gateway
globus-connect-server collection create STORAGE_GATEWAY_ID / "My Tutorial Mapped Collection – Restricted"

# Subscribe your endpoint ...or ask the Globus team to do it
globus-connect-server endpoint set-subscription-id YOUR_SUBSCRIPTION_ID

# Allow sharing (creation of guest collections) on mapped collection
globus-connect-server collection update MAPPED_COLLECTION_ID --allow-guest-collections

# Allow browser-based HTTPS uploads and downloads
globus-connect-server collection update COLLECTION_ID --enable-https

# Setting the default directory for a collection
# Note: $USER is not a shell variable; it has special meaning to GCS
globus-connect-server collection update COLLECTION_ID --default-directory '/home/$USER/'

# Delegating administration/management using endpoint roles
# Make members of the Tutorial Users group Activity Managers on your endpoint
globus-connect-server endpoint role create activity_manager --principal-type group 50b6a29c-63ac-11e4-8062-22000ab68755

# ------- Restrict sharing to users from a specific domain -------
# Step 1: Create the sharing authentication policy
globus-connect-server auth-policy create \
--include uchicago.edu \
--description "Only share with users that present a uchicago.edu credential" \
--display-name "Restricted uchicago.edu sharing policy"

# Step 2: Attach the policy to the mapped collection
globus-connect-server collection update \
MAPPED_COLLECTION_ID \
--guest-auth-policy-id AUTH_POLICY_UUID 


# ------- Installing multi-DTN endpoints -------
# Adding nodes (DTNs) to an endpoint
sudo globus-connect-server node setup --deployment-key DEPLOYMENT_KEY_FILENAME
sudo systemctl restart apache2

  
# ------- Migrating nodes -------
# Save node configuration on existing DTN to a file
sudo globus-connect-server node setup \
--deployment-key ENDPOINT_DEPLOYMENT_KEY \
--export-node NODE_CONFIG_FILENAME

# Restore node configuration from file on new DTN
sudo globus-connect-server node setup \
--deployment-key DEPLOYMENT_KEY_FILENAME \
--import-node NODE_CONFIG_FILENAME


# ------- Troubleshooting GCS installation -------
# Show GCS configuration details and check status of the various GCS services
globus-connect-server self-diagnostic

# Check GCS Manager connectivity
export GCS_DNS=YOUR_GCS_DNS_NAME

# Check DNS resolution of GCS Manager
dig +short $GCS_DNS

# Confirm that it resolves to your DTN(s) IP address(es)
globus-connect-server node list

# Ensure no "timeout" or "no route to host" errors for each DTN
curl -vk --resolve $GCS_DNS:443:DTN_IP_ADDRESS https://$GCS_DNS/api/info


# ------- Customizing identity mapping -------
# Create a file with identity mapping rules (id-rules.json)
{
  "DATA_TYPE": "expression_identity_mapping#1.0.0",
  "mappings": [
    {
      "source": "{username}",
      "match": “YOUR_ID@YOUR_IDP",
      "output": "YOUR_SPECIAL_LOCAL_USERNAME",
      "ignore_case": false,
      "literal": false
    },
    {
      "source": "{username}",
      "match": ".*@uchicago.edu",
      "output": "{0}",
      "ignore_case": false,
      "literal": false
    }
  ]
}


# ------- Accessing non-POSIX storage -------
# Creating a storage gateway to access AWS S3 buckets
globus-connect-server storage-gateway create s3 \
'My Tutorial S3 Storage Gateway' \
--domain 'uchicago.edu' \
--s3-endpoint https://s3.amazonaws.com \
--bucket MY_BUCKET \
--s3-user-credential

# Create a mapped collection to access AWS S3 buckets
globus-connect-server collection create STORAGE_GATEWAY_ID / 'My Tutorial S3 Collection'


# ------- Cleaning up! -------
# Deleting the endpoint requires multiple steps
# Run the following two commands in the order shown
sudo globus-connect-server node cleanup
globus-connect-server endpoint cleanup --deployment-key DEPLOYMENT_KEY_FILENAME


# ------- Using client credentials to manage GCS resources -------
# Sample code: gist.github.com/vasv/cdb8607e2bfab08634b5aa99389e87c7

### EOF
