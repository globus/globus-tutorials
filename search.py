'''
Replace the SEARCH_INDEXES dictionary in
~/$PROJECT_SLUG/$PROJECT_SLUG/settings/search.py 
'''

SEARCH_INDEXES = {
    "terrafusion": {
        "uuid": "6be80847-70f9-4441-9075-f9348d6b044a",
        "name": "OSN",
        "template_override_dir": "osn",
        "fields": [
            "files",
            ("title", fields.title),
            ("https_url", fields.https_url),
            ("detail_general_metadata", fields.detail_general_metadata),
            ("copy_to_clipboard_link", fields.https_url),
            ("globus_app_link", fields.globus_app_link),
        ],
        "facets": [
            {
                "name": "Year",
                "field_name": "year",
            },
            {
                "name": "Survey Number",
                "field_name": "survey",
            },
        ],
        "sort": [{"field_name": "year", "order": "asc"}],
    }
}
