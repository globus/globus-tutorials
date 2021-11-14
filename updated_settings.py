SEARCH_INDEXES = {
    'sfiles': {
        'name': 'Searchable Files',
        'uuid': 'YOUR_INDEX_UUID',
        'fields': [
            'name',
            'extension',
            'size_bytes',
            'mtime',
        ],
        'facets': [
            {
                'name': 'Extension',
                'field_name': 'extension',
                'size': 10,
                'type': 'terms'
            },
            {
                'name': 'File Size (Bytes)',
                'type': 'numeric_histogram',
                'field_name': 'size_bytes',
                'size': 10,
                'histogram_range': {'low': 150000000, 'high': 300000000},
            },
            {
                "name": "Modification Time",
                "field_name": "mtime",
                "type": "date_histogram",
                "date_interval": "month",
            },
        ],
        'filter_match': 'match-all',
        'template_override_dir': '',
        'test_index': True,
    }
}
