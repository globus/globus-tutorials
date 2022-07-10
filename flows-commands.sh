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

# Edit simple_script.py
cd simple_script
vi simple_script.py

# Modify "source_id" (on line 21)
source_id = YOUR_GCP_ENDPOINT_ID

# Activate Python virtual environment

# Run the trigger script


