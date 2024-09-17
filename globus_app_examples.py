import globus_sdk
from globus_sdk.experimental.globus_app import UserApp, ClientApp

# UserApp - acts as the user
USER_APP_CLIENT_ID = "REPLACE_WITH_NATIVE_APP_ID"

# ClientApp - acts as the service account/application itself
SVC_ACCT_CLIENT_ID = "REPLACE_WITH_SERVICE_ACCOUNT_ID"
SVC_ACCT_CLIENT_SECRET = "REPLACE_WITH_SERVICE_ACCOUNT_SECRET"


def main():
    my_user_app = UserApp(
        "my-user-app",
        client_id=USER_APP_CLIENT_ID
    )

    # Bind UserApp object to a Globus Transfer service client
    transfer_client = globus_sdk.TransferClient(app=my_user_app)

    # Access the Globus Transfer API
    # List my recently used collections
    collections = transfer_client.endpoint_search(filter_scope="recently-used")

    print("My Recently Used Collections:")
    for collection in collections:
        print(f"{collection['id']} --- {collection['display_name']}")

    my_svc_acct = ClientApp(
        "my-svc-acct",
        client_id=SVC_ACCT_CLIENT_ID,
        client_secret=SVC_ACCT_CLIENT_SECRET
    )

    # Access the Globus Transfer API using the service account (ClienApp object)
    transfer_client = globus_sdk.TransferClient(app=my_svc_acct)
    collections = transfer_client.endpoint_search(filter_scope="recently-used")

    print("Recently Used Collections for the Service Account")
    for collection in collections:
        print(f"{collection['id']} --- {collection['display_name']}")
    print("\nSurpised by the (lack of) data?")

    # Bind ClientApp object to a Globus Auth service client
    auth_client = globus_sdk.AuthClient(app=my_svc_acct)

    # Access the Globus Auth API using the service account
    identities = auth_client.get_identities(
        usernames=["ENTER_ONE_OR_MORE_IDENTITIES_SEPARATED_BY_COMMAS"]
    )

    print("Found the following identity information...")
    for identity in identities:
        print(f"Username {identity['username']} is known as {identity['name']} at \
    {identity['organization'] if identity['organization'] else 'UNKNOWN_ORGANIZATION'} ")

if __name__ == "__main__":
    main()