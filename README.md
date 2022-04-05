# Globus Tutorial Sample Code and Command Cheatsheet
Sample code and commands for deploying and configuring the Globus portal framework and other bits.

1. Before deploying the portal code register a  Globus Auth client at https://developers.globus.org
2. Deploy the portal framework using [the commands here](commands.sh)

To customize the portal configuration to use a different search index:
1. Edit `~/$SLUG/$SLUG/settings/search.py` (make a backup copy first, so you can revert later)
2. Change the search index ID to `0bfd892f-3112-4a3a-81d4-00de69b3fcc9`.
3. Edit `
