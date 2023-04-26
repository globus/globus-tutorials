# Set up Globus Connect Personal on your EC2 instance

# Shell into instance using the devN local account
ssh devN@tutN.globusdemo.org

# Install GCP
cd globusconnectpersonal-3.2.0
./globusconnectpersonal
# Name your GCP endpoint: Event - Your Name

# Start GCP
./globusconnectpersonal -start &

### Register Globus Compute endpoint

# Activate Python virtualenv
source ~/.compute/bin/activate

### Create and start the Globus Compute endpoint

globus-compute-endpoint configure
globus-compute-endpoint start default

# Register a Python function with the Globus Compute service
python ~/globus-flows-trigger-examples/compute_function.py

### Invoke a function

# Function generates thumbnails for all PNG image files in a specified directory
from globus_compute_sdk import Client
client = Client()
func_id = 'REGISTERED_FUNCTION_UUID'
ep_id = 'GLOBUS_COMPUTE_ENDPOINT_ID'
result = client.run('/home/devN/test-data', '/home/devN/processed', endpoint_id=ep_id, function_id=func_id)

# Retrieve compute result (should be 'None' if no error)
print (client.get_result(result))

### Trigger a flow by filesystem events

# Activate Python virtual environment
source ~/.trigger/bin/activate
cd ~/globus-flows-trigger-examples

# Deploy the transfer, compute, transfer, and share flow
./deploy_flow.py \
--flowdef transfer_compute_share_definition.json
--schema transfer_compute_share_schema.json
--title 'YOUR_FLOW_NAME'

# Edit trigger_transfer_compute_share_flow.py
# modify "flow_id", "source_id", "destination_base_path" and "search_index"
vi ~/globus-flows-trigger-examples/trigger_transfer_compute_share_flow.py

flow_id = 'REPLACE_WITH_FLOW_ID'  # on line 14
source_id = 'REPLACE_WITH_SOURCE_COLLECTION_ID'  # on line 23
destination_id = 'REPLACE_WITH_DESTINATION_COLLECTION_ID'  # on line 27
destination_base_path = '/home/devN/scratch/'  # on line 31
compute_endpoint_id = 'REPLACE_WITH_COMPUTE_ENDPOINT_ID'  # on line 34
compute_function_id = 'REPLACE_WITH_REGISTERED_FUNCTION_ID'  # on line 37
resultshare_path = '/automation-tutorial/compute-results/USERNAME/'  # on line 46

# Run the trigger script
# When a file ending in .done is created, it will trigger the Globus Flow
cd ~/globus-flows-trigger-examples
./trigger_transfer_compute_share_flow.py \
--watchdir /home/devN/images \
--patterns .done

### EOF
