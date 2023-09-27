import os
import requests
import hashlib

# Server URL
SERVER_URL = "http://server:5000"

def download_file():
    response = requests.get(f"{SERVER_URL}/")
    data = response.json()
    file_path = data['file_path']
    checksum = data['checksum']

    # Verify file integrity
    with open(file_path, 'rb') as file:
        file_data = file.read()
        file_checksum = hashlib.sha256(file_data).hexdigest()

    if file_checksum == checksum:
        with open("/clientdata/downloaded_data.txt", 'wb') as output_file:
            output_file.write(file_data)
        print("File downloaded successfully.")
    else:
        print("File integrity check failed.")

if __name__ == '__main__':
    download_file()
