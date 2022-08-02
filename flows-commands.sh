# Set up Globus Connect Personal on your EC2 instance

# Shell into instance using the devN local account
ssh devN@tutN.globusdemo.org

# Install GCP
cd globusconnectpersonal-3.1.6
./globusconnectpersonal
# Name your GCP endpoint: RMACC22 GCP YOUR_NAME

# Start GCP
./globusconnectpersonal -start &

# Using trigger script to run a Globus Flow

# Get the ID of the GCP endpoint on your instance
globus login   # optional
globus endpoint search 'RMACC22'

# Edit simple_script.py; modify "source_id" and "remote_path"
# When triggered, this Globus Flow will move file to this collection/path
cd ~/globus-flows-trigger-examples
vi ~/globus-flows-trigger-examples/trigger_transfer_share_flow.py

flow_id = 'YOUR_FLOW_ID_FROM_NOTEBOOK'  # on line 14
source_id = 'YOUR_GCP_ENDPOINT_ID'  # on line 19
destination_base_path = '/automation-tutorial/YOUR_NAME/'  # on line 28

# Activate Python virtual environment
source ~/.trigger/bin/activate

# Run the trigger script
cd ~/globus-flows-trigger-examples
./trigger_transfer_share_flow.py --watchdir `pwd`/testData --patterns .done

# Edit trigger_transfer_publish_flow.py; modify "flow_id", "source_id", "remote_path" and "search_index"
# When triggered, this Globus Flow will push file metadata to the index we created earlier 
flow_id = 'YOUR_FLOW_ID_FROM_NOTEBOOK'  # on line 16
source_id = 'YOUR_GCP_ENDPOINT_ID'  # on line 21
destination_base_path = '/automation-tutorial/YOUR_NAME/'  # on line 30
search_index = 'YOUR_GLOBUS_SEARCH_INDEX_ID_FROM_NOTEBOOK'   # on line 37

# Run the script to ingest search metadata
cd ~/globus-flows-trigger-examples
./trigger_transfer_publish_flow.py --watchdir `pwd`/testData --patterns .done

### EOF
