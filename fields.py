from urllib.parse import urlsplit, urlunsplit, urlencode

def title(result):
    return result[0]['files'][0]['filename']

def https_url(result):
    path = urlsplit(result[0]['files'][0]['url']).path
    return urlunsplit(('https', 'g-13a6e8.f9e26.5898.data.globus.org', path, '', ''))

def preview_url(result):
    path = urlsplit(result[0]['files'][0]['preview_url']).path
    return urlunsplit(('https', 'g-13a6e8.f9e26.5898.data.globus.org', path, '', ''))

def detail_general_metadata(result):
    fields = [
        {"field_name": "year", "name": "Year", "value": result[0]["year"]},
        {"field_name": "gps_lat", "name": "Latitude", "value": result[0]["gps_lat"]},
        {"field_name": "gps_lon", "name": "Longitude", "value": result[0]["gps_lon"]},
        {"field_name": "gps_alt", "name": "Altitude (m)", "value": result[0]["gps_alt"]},
        {"field_name": "file_size", "name": "File Size", "value": result[0]["file_size"]},
        {"field_name": "width", "name": "Image Width", "value": result[0]["width"]},
        {"field_name": "height", "name": "Image Height", "value": result[0]["height"]},
        {"field_name": "survey", "name": "Survey Number", "value": result[0]["survey"]},
        {"field_name": "s3_url", "name": "S3 URL", "value": result[0]["s3_url"]},
    ]
    return fields

def globus_app_link(result):
    query_params = {'origin_id': "fe2feb64-4ac0-4a40-ba90-94b99d06dd2c",
                    'origin_path': f"/dgpf_sample_data/{result[0]['survey']}"}
    return urlunsplit(('https', 'app.globus.org', 'file-manager',
                      urlencode(query_params), ''))