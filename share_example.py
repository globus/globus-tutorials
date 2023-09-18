import globus_sdk

# you must have a client ID
CLIENT_ID = "6afa2dc5-d219-4078-9a06-ba37aa32c739"
# the secret, loaded from wherever you store it
CLIENT_SECRET = "y+bN3uI5nepin/8dlHzpxSnEc7AK6lpYSnLNKuLSVzU="

collection_id = "bef195ac-509f-11ee-8152-15041d20ea55"
identity_id = "c5f361fc-25b4-4675-b591-7314b7ba5721"

client = globus_sdk.ConfidentialAppAuthClient(CLIENT_ID, CLIENT_SECRET)
token_response = client.oauth2_client_credentials_tokens()

scopes = "urn:globus:auth:scope:transfer.api.globus.org:all"
cc_authorizer = globus_sdk.ClientCredentialsAuthorizer(client, scopes)
# create a new client
transfer_client = globus_sdk.TransferClient(authorizer=cc_authorizer)

rule_data = {
    "DATA_TYPE": "access",
    "principal_type": "identity",
    "principal": identity_id,
    "path": "/dataset1/",
    "permissions": "rw",
}
result = transfer_client.add_endpoint_acl_rule(collection_id, rule_data)
rule_id = result["access_id"]