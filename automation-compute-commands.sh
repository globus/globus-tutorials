# Set up Globus Connect Personal on your EC2 instance

# Shell into instance using the devN local account
ssh devN@tutN.globusdemo.org

# Install GCP
cd globusconnectpersonal-3.2.0
./globusconnectpersonal
# Name your GCP endpoint: Event - Your Name

# Start GCP
./globusconnectpersonal -start &

# Register Globus Compute endpoint

# Activate Python virtualenv
source ~/.compute/bin/activate

# Create and start the Globus Compute endpoint
globus-compute-endpoint configure
globus-compute-endpoint start default

# Register a Python function with the Globus Compute service
python ~/globus-flows-trigger-examples/compute_function.py

# Invoke a function
# Function generates thumbnails for all PNG image files in a specified directory
from globus_compute_sdk import Client
client = Client()
func_id = 'REGISTERED_FUNCTION_UUID'
ep_id = 'GLOBUS_COMPUTE_ENDPOINT_ID'
result = client.run('/home/dev100/test-data', '/home/dev100/scratch', endpoint_id=ep_id, function_id=func_id)


### EOF
