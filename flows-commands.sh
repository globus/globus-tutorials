# Set up Globus Connect Personal on your EC2 instance

# Shell into instance using the devN local account
ssh devN@tutN.globusdemo.org

# Install GCP
cd globusconnectpersonal-3.2.0
./globusconnectpersonal
# Name your GCP endpoint: EVENT_NAME_YOUR_NAME

# Start GCP
./globusconnectpersonal -start &

# Using trigger script to run a Globus Flow

# Get the ID of the GCP endpoint on your instance
globus login   # optional
globus endpoint search 'EVENT_NAME_YOUR_NAME'   # optional

# For Flow 1: Transfer and Share ----
cd ~/globus-flows-trigger-examples

# OPTIONAL: If you did not run the Jupyter notebook to deploy your flow
# you can do so directly from your instance by running the command below
# ./deploy_flow.py --defs def_transfer_share_flow.json --title 'YOUR_FLOW_NAME'

# Edit trigger_transfer_share_flow.py
# modify "flow_id", source_id" and "destination_base_path"
vi ~/globus-flows-trigger-examples/trigger_transfer_share_flow.py

flow_id = 'YOUR_FLOW_ID_FROM_NOTEBOOK'  # on line 14
source_id = 'YOUR_GCP_ENDPOINT_ID'  # on line 23
destination_base_path = '/automation-tutorial/YOUR_NAME/'  # on line 32

# Activate Python virtual environment
source ~/.trigger/bin/activate

# Run the trigger script
# When a file ending in .done is created, it will trigger the Globus Flow
# The flow will move files to the guest collection/path and add sharing permissions
cd ~/globus-flows-trigger-examples
./trigger_transfer_share_flow.py --watchdir `pwd`/testData --patterns .done

# For Flow 2: Transfer and Publish ----
cd ~/globus-flows-trigger-examples

# OPTIONAL: If you did not run the Jupyter notebook to deploy your flow
# you can do so directly from your instance by running the command below
# ./deploy_flow.py --defs def_transfer_publish_flow.json --title 'YOUR_FLOW_NAME'

# Edit trigger_transfer_publish_flow.py
# modify "flow_id", "source_id", "destination_base_path" and "search_index"
vi ~/globus-flows-trigger-examples/trigger_transfer_publish_flow.py

flow_id = 'YOUR_FLOW_ID_FROM_NOTEBOOK'  # on line 16
source_id = 'YOUR_GCP_ENDPOINT_ID'  # on line 25
destination_base_path = '/automation-tutorial/YOUR_NAME/'  # on line 34
search_index = 'YOUR_GLOBUS_SEARCH_INDEX_ID_FROM_NOTEBOOK'   # on line 41

# Run the trigger script
# When a file ending in .done is created, it will trigger the Globus Flow
# The flow will transfer/share data and push metadata to the index we created earlier
cd ~/globus-flows-trigger-examples
./trigger_transfer_publish_flow.py --watchdir `pwd`/testData --patterns .done

### EOF
