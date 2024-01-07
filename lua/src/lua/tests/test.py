import requests

endpoint = "http://localhost:8085/hello"
response = requests.get(endpoint)
print(response.status_code)
print(response.text)
