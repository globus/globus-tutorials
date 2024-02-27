#!/bin/bash

# This script transfers a folder to a guest collection
# and grants access to a specified user or group.

function help_and_exit () {

    echo -e 'Usage:' \
        "$0 --source-collection <UUID> --source-path <PATH> --guest-collection <UUID> --sharing-path <PATH> [-h|--help]"
    echo ''
    echo 'The following options are available:'
    echo ''
    echo '  --source-collection: The collection you want to copy data from'
    echo '  --source-path: The path to the folder you want to copy to '
    echo '    your "--guest-collection"'
    echo '  --guest-collection: A guest collection from which to share the data'
    echo '  --sharing-path: The guest collection path where data will be copied'
    echo '  --user-id (or --user-uuid): Globus identity to share data with'
    echo '  --group-id (or --group-uuid): Globus Group ID to share with'
    echo '  --read-write: Grant read and write permissions; default is read-only'
    echo '  -h: Print this help message'
    echo ''
    echo "Example: $0 --source-collection ddb59aef-6d04-11e5-ba46-22000b92c6ec --source-path /share/godata --destination-path /shared_folder_example --guest-collection <your-guest-collection>"
    echo ''
    echo 'Go to "https://app.globus.org/file-manager", navigate to your collection,'
    echo 'select a folder, and click "Share" to create a guest collection'
    echo ''
    exit 0

}

if [ $# -eq 0 ]; then
    help_and_exit
fi


while [ $# -gt 0 ]; do
    key="$1"
    case $1 in
        --source-collection)
            shift
            source_collection=$1
        ;;
        --guest-collection)
            shift
            guest_collection=$1
        ;;
        --source-path)
            shift
            source_path=$1
        ;;
        --sharing-path)
            shift
            sharing_path=$1
        ;;
        --user-uuid|--user-id)
            shift
            user_id=$1
        ;;
        --group-uuid|--group-id)
            shift
            group_id=$1
        ;;
        --read-write)
            shift
            read_write='yes'
        ;;
        -h|--help)
            help_and_exit
        ;;
        *)
            echo ''
            echo "Error: Unknown Option: '$1'"
            echo ''
            echo "$0 --help for options and more information."
            exit 1
    esac
    shift
done

if [ -z $source_collection ]; then
    echo 'Error: Source collection is not defined' >&2
    exit 1
fi

if [ -z $guest_collection ]; then
    echo 'Error: Guest collection is not defined' >&2
    exit 1
fi

case "$sharing_path" in
    /*)
        ;;
    *)
        echo 'Destination (sharing) path must be absolute' >&2
        exit 1
        ;;
esac

case "$source_path" in
    /*)
    ;;
    *)
        echo 'Source path must be absolute' >&2
        exit 1
    ;;
esac

globus ls "$guest_collection:$sharing_path" 2>/dev/null
if [ $? -gt 0 ]; then
    echo "Creating destination directory $sharing_path"
    globus mkdir "$guest_collection:$sharing_path"
fi

basename=`basename "$source_path"`
# Add '/' if the user didn't provide one
if [ "${sharing_path: -1}" != "/" ]; then
    sharing_path="$sharing_path/"
fi
destination_directory="$sharing_path$basename/"

if [ -n "$read_write" ]; then
    permissions='rw'
else
    permissions='r'
fi

if [ -n "$user_id" ]; then
    echo "Granting user, $user_id, read access to the destination directory"
    globus endpoint permission create --identity "$user_id" --permissions $permissions "$guest_collection:$destination_directory"
fi
if [ -n "$group_id" ]; then
    echo "Granting group, $group_id, read access to the destination directory"
    globus endpoint permission create --group $group_id --permissions $permissions "$guest_collection:$destination_directory"
fi

echo "Submitting a transfer from $source_collection:$source_path to $guest_collection:$destination_directory"
exec globus transfer --recursive --label 'Transfer Share Data CLI Script' "$source_collection:$source_path" "$guest_collection:$destination_directory"
