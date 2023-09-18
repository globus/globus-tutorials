# Collection IDs

# Tutorial Guest Collection
id: fe2feb64-4ac0-4a40-ba90-94b99d06dd2c
working_dir: /automation-tutorial/

# Globus Tutorials on ALCF Eagle (also a guest collection)
id: a6f165fa-aee2-4fe5-95f3-97429c28bf82
working_dir: /automation-tutorial/


### Register a Globus Compute endpoint

# Shell into your instance using the devN local account
ssh devN@tutN.globusdemo.org

# Activate Python virtualenv
source ~/.compute/bin/activate

### Create and start the Globus Compute endpoint
globus-compute-endpoint configure EP_NAME
globus-compute-endpoint start EP_NAME

# Register a Python function with the Globus Compute service
python ~/globus-flows-trigger-examples/functions/compute_function.py

# Set up Globus Connect Personal on your instance
# Install GCP
cd ~/globusconnectpersonal-3.2.2
./globusconnectpersonal
# Name your GCP endpoint: Event - Compute

# Start GCP
./globusconnectpersonal -start &

# Claim a second (cryoN) instance to act as your "instrument"
# shell into instance using the devN local account
ssh devN@cryoN.globusdemo.org  # NOTE: cryoN <--

# Install GCP on the "instrument" instance
cd ~/globusconnectpersonal-3.2.2
./globusconnectpersonal
# Name your GCP endpoint: Event - Instrument

### Trigger a flow by filesystem events

# Activate Python virtual environment
source ~/.trigger/bin/activate
cd ~/globus-flows-trigger-examples

# Deploy the transfer, compute, transfer, and share flow
./deploy_flow.py \
--flowdef transfer_compute_share/definition.json \
--schema transfer_compute_share/schema.json \
--title 'YOUR_FLOW_NAME'

# Edit trigger_transfer_compute_share_flow.py
# and modify the variables below
vi ~/globus-flows-trigger-examples/trigger_transfer_compute_share_flow.py

flow_id = 'REPLACE_WITH_FLOW_ID'  # on line 14
source_id = 'REPLACE_WITH_SOURCE_COLLECTION_ID'  # on line 22
destination_id = 'REPLACE_WITH_DESTINATION_COLLECTION_ID'  # on line 26
destination_base_path = '/home/devN/scratch/'  # on line 30
compute_endpoint_id = 'REPLACE_WITH_COMPUTE_ENDPOINT_ID'  # on line 33
compute_function_id = 'REPLACE_WITH_REGISTERED_FUNCTION_ID'  # on line 36
resultshare_id = "fe2feb64-4ac0-4a40-ba90-94b99d06dd2c"  # on line 41
resultshare_path = '/automation-tutorial/compute-results/USERNAME/'  # on line 45

# Run the trigger script
# When a file ending in .done is created, it will trigger the Globus Flow
cd ~/globus-flows-trigger-examples
./trigger_transfer_compute_share_flow.py \
--watchdir /home/devN/images \
--patterns .done

# Fire the trigger
# Use a tmux session or a separate shell
$ tmux

# Create files that mimic an instrument generating data
$ cp ~/test-data/*.png ~/images

# Create a file that matches the pattern being monitored
# Sadly, no instrument is actually this "nice"!
$ touch ~/images/iam.done


### Invoke a function

# Function generates thumbnails for all PNG image files in a specified directory
from globus_compute_sdk import Client
client = Client()
func_id = 'REGISTERED_FUNCTION_UUID'
ep_id = 'GLOBUS_COMPUTE_ENDPOINT_ID'
result = client.run('/home/devN/test-data', '/home/devN/processed', endpoint_id=ep_id, function_id=func_id)

# Retrieve compute result (should be 'None' if no error)
print (client.get_result(result))

### EOF
