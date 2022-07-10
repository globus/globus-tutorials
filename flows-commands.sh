# Set up Globus Connect Personal on your EC2 instance

# Shell into instance using the devN local account
ssh devN@tutN.globusdemo.org

# Install GCP
cd globusconnectpersonal-3.1.6
./globusconnectpersonal
# Name your GCP endpoint: PEARC22 GCP YOUR_NAME

# Start GCP
./globusconnectpersonal -start &

# Using trigger script to run a Globus Flow

# Get the ID of the GCP endpoint on your instance
globus login   # optional
globus endpoint search 'PEARC22'

# Edit simple_script.py; modify "source_id" and "remote_path"
# When triggered, the Glbous Flow will move file to this collection/path
cd ~/simple_sync
vi ~/simple_sync/simple_sync.py

source_id = 'YOUR_GCP_ENDPOINT_ID'  # on line 21
remote_path = '/flows/YOUR_NAME/'   # on line 27

# Activate Python virtual environment
source ~/.trigger/bin/activate

# Run the trigger script
cd ~/simple_sync
./simple_sync.py --localdir `pwd`/testData --include .done

# Edit simple_sync_publish.py
flow_id = YOUR_GLOBUS_FLOW_ID_FROM_NOTEBOOK   # on line 19
source_id = YOUR_GCP_ENDPOINT_ID   # on line 24
remote_path = '/flows/YOUR_NAME/'   # on line 30

# Run the script to ingest search metadata
./simple_sync_publish.py
